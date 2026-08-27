#!/usr/bin/env python3
"""
ORO 3D & GLB Automation Pipeline
Automates the conversion, preprocessing, and optimization of 2D product images
into 360° interactive turntable assets and production-ready 3D GLB models.
"""

import os
import sys
import json
import struct
import math
import argparse
from pathlib import Path

# Configuración y Parámetros Estándar ORO PBR
ORO_PBR_PRESETS = {
    "gold_18k": {
        "base_color": [0.90, 0.78, 0.47, 1.0],  # #E6C779
        "metallic": 1.0,
        "roughness": 0.18,
    },
    "gold_24k": {
        "base_color": [1.0, 0.84, 0.0, 1.0],   # #FFD700
        "metallic": 1.0,
        "roughness": 0.12,
    },
    "emerald_gem": {
        "base_color": [0.08, 0.58, 0.35, 0.85], # #158352
        "metallic": 0.1,
        "roughness": 0.05,
    },
    "night_blue_glass": {
        "base_color": [0.03, 0.08, 0.13, 0.90], # #071420
        "metallic": 0.4,
        "roughness": 0.10,
    }
}

PROMPT_TEMPLATE = """Generate a production-ready 3D e-commerce product model from this reference. Preserve the exact silhouette, proportions, colors, logo placement, seams, materials and all visible details. Create complete front, back, sides, top and bottom geometry; do not invent text, brands, accessories or patterns. Use physically based rendering materials: realistic base color, normal, roughness, metallic and ambient-occlusion maps. Center the model, use a bottom-center pivot, clean UVs, clean topology, no floating fragments, no background plane, no mannequin, no human body. Optimize for Android mobile real-time rendering, export as GLB, with 2K PBR textures."""

def generate_meshy_task_payload(image_paths, product_name, category="jewelry"):
    """Genera la carga de solicitud para la API de Meshy / Tripo AI."""
    payload = {
        "product_name": product_name,
        "category": category,
        "mode": "multi_view" if len(image_paths) > 1 else "single_image",
        "images": [str(p) for p in image_paths],
        "prompt": PROMPT_TEMPLATE,
        "export_format": "glb",
        "pbr_textures": ["base_color", "metallic", "roughness", "normal", "occlusion"],
        "texture_resolution": 2048,
        "target_polycount": 25000,
        "auto_center_pivot": "bottom_center",
        "remove_background": True
    }
    return payload

def create_procedural_oro_glb(output_path, model_type="gold_ingot", preset_name="gold_24k"):
    """
    Crea un archivo binario .GLB (glTF 2.0 Binary) de producción válido
    con materiales PBR Oro/Esmeralda y geometría limpia centrada.
    """
    os.makedirs(os.path.dirname(os.path.abspath(output_path)), exist_ok=True)
    preset = ORO_PBR_PRESETS.get(preset_name, ORO_PBR_PRESETS["gold_24k"])
    
    # Geometría básica según el tipo de objeto (ej: Lingote de Oro ORO con biseles)
    if model_type == "gold_ingot":
        # Vértices de un lingote trapezoidal de oro (X, Y, Z)
        # Base inferior (ancho: 1.6, largo: 3.2, alto: 0.0)
        # Base superior (ancho: 1.2, largo: 2.6, alto: 0.6)
        positions = [
            # Base inferior (-Z = fondo, +Y = arriba)
            -0.8, 0.0, -1.6,   0.8, 0.0, -1.6,   0.8, 0.0,  1.6,  -0.8, 0.0,  1.6,
            # Tapa superior
            -0.6, 0.6, -1.3,   0.6, 0.6, -1.3,   0.6, 0.6,  1.3,  -0.6, 0.6,  1.3,
        ]
        # Índices de triángulos (12 caras trianguladas = 36 índices)
        indices = [
            # Tapa superior (2 triángulos)
            4, 5, 6,  4, 6, 7,
            # Base inferior
            0, 2, 1,  0, 3, 2,
            # Frontal (+Z)
            3, 2, 6,  3, 6, 7,
            # Trasera (-Z)
            1, 0, 4,  1, 4, 5,
            # Lateral izquierda (-X)
            0, 3, 7,  0, 7, 4,
            # Lateral derecha (+X)
            2, 1, 5,  2, 5, 6
        ]
        normals = [
            -0.5, -0.5, -0.5,   0.5, -0.5, -0.5,   0.5, -0.5,  0.5,  -0.5, -0.5,  0.5,
            -0.2,  0.9, -0.2,   0.2,  0.9, -0.2,   0.2,  0.9,  0.2,  -0.2,  0.9,  0.2,
        ]
    else:
        # Prisma de Joya / Anillo ORO
        segments = 16
        radius_out = 1.0
        radius_in = 0.75
        height = 0.35
        positions = []
        normals = []
        indices = []
        for i in range(segments):
            angle = (i / segments) * 2 * math.pi
            ca = math.cos(angle)
            sa = math.sin(angle)
            # Exterior inferior, Exterior superior, Interior inferior, Interior superior
            positions.extend([
                radius_out * ca, 0.0, radius_out * sa,
                radius_out * ca, height, radius_out * sa,
                radius_in * ca, 0.0, radius_in * sa,
                radius_in * ca, height, radius_in * sa
            ])
            normals.extend([
                ca, 0.0, sa,
                ca, 0.5, sa,
                -ca, 0.0, -sa,
                -ca, 0.5, -sa
            ])
        for i in range(segments):
            next_i = (i + 1) % segments
            b = i * 4
            nb = next_i * 4
            # Cara exterior
            indices.extend([b, b+1, nb+1,  b, nb+1, nb])
            # Cara superior
            indices.extend([b+1, b+3, nb+3,  b+1, nb+3, nb+1])
            # Cara interior
            indices.extend([b+2, nb+2, nb+3,  b+2, nb+3, b+3])
            # Cara inferior
            indices.extend([b, nb, nb+2,  b, nb+2, b+2])

    # Serializar buffers binarios
    pos_bytes = struct.pack(f"<{len(positions)}f", *positions)
    norm_bytes = struct.pack(f"<{len(normals)}f", *normals)
    ind_bytes = struct.pack(f"<{len(indices)}H", *indices)

    # Padding a 4 bytes
    while len(pos_bytes) % 4 != 0: pos_bytes += b'\x00'
    while len(norm_bytes) % 4 != 0: norm_bytes += b'\x00'
    while len(ind_bytes) % 4 != 0: ind_bytes += b'\x00'

    bin_data = ind_bytes + pos_bytes + norm_bytes

    offset_indices = 0
    len_indices = len(ind_bytes)
    offset_pos = len_indices
    len_pos = len(pos_bytes)
    offset_norm = offset_pos + len_pos
    len_norm = len(norm_bytes)

    min_pos = [min(positions[i::3]) for i in range(3)]
    max_pos = [max(positions[i::3]) for i in range(3)]

    # Estructura JSON glTF 2.0 con PBR Metallic Roughness
    gltf_dict = {
        "asset": {
            "version": "2.0",
            "generator": "ORO 3D Pipeline 2026 - Physically Based Renderer"
        },
        "scene": 0,
        "scenes": [{"nodes": [0]}],
        "nodes": [{
            "mesh": 0,
            "name": f"ORO_{model_type.upper()}"
        }],
        "meshes": [{
            "name": f"ORO_{model_type}",
            "primitives": [{
                "attributes": {
                    "POSITION": 1,
                    "NORMAL": 2
                },
                "indices": 0,
                "material": 0
            }]
        }],
        "materials": [{
            "name": "ORO_PBR_GoldMaterial",
            "pbrMetallicRoughness": {
                "baseColorFactor": preset["base_color"],
                "metallicFactor": preset["metallic"],
                "roughnessFactor": preset["roughness"]
            },
            "doubleSided": True
        }],
        "accessors": [
            {
                "bufferView": 0,
                "componentType": 5123, # UNSIGNED_SHORT
                "count": len(indices),
                "type": "SCALAR"
            },
            {
                "bufferView": 1,
                "componentType": 5126, # FLOAT
                "count": len(positions) // 3,
                "type": "VEC3",
                "min": min_pos,
                "max": max_pos
            },
            {
                "bufferView": 2,
                "componentType": 5126, # FLOAT
                "count": len(normals) // 3,
                "type": "VEC3"
            }
        ],
        "bufferViews": [
            {
                "buffer": 0,
                "byteOffset": offset_indices,
                "byteLength": len_indices,
                "target": 34963 # ELEMENT_ARRAY_BUFFER
            },
            {
                "buffer": 0,
                "byteOffset": offset_pos,
                "byteLength": len_pos,
                "target": 34962 # ARRAY_BUFFER
            },
            {
                "buffer": 0,
                "byteOffset": offset_norm,
                "byteLength": len_norm,
                "target": 34962 # ARRAY_BUFFER
            }
        ],
        "buffers": [{
            "byteLength": len(bin_data)
        }]
    }

    json_str = json.dumps(gltf_dict)
    json_bytes = json_str.encode('utf-8')
    # Alinear JSON a 4 bytes con espacios
    while len(json_bytes) % 4 != 0:
        json_bytes += b' '

    # Estructura del contenedor GLB Binario (Header + CHUNK 0 JSON + CHUNK 1 BIN)
    # Magic = 0x46546C67 ('glTF'), Version = 2
    total_length = 12 + 8 + len(json_bytes) + 8 + len(bin_data)
    header = struct.pack("<4sII", b'glTF', 2, total_length)
    chunk0_header = struct.pack("<II", len(json_bytes), 0x4E4F534A) # 'JSON'
    chunk1_header = struct.pack("<II", len(bin_data), 0x004E4942)   # 'BIN\x00'

    with open(output_path, "wb") as f:
        f.write(header)
        f.write(chunk0_header)
        f.write(json_bytes)
        f.write(chunk1_header)
        f.write(bin_data)

    print(f"[*] Modelo 3D GLB exportado exitosamente: {output_path} ({total_length} bytes)")
    return output_path

def main():
    parser = argparse.ArgumentParser(description="ORO 3D & GLB Product Pipeline")
    parser.add_argument("--action", choices=["create_glb", "generate_prompt", "all"], default="all")
    parser.add_argument("--type", choices=["gold_ingot", "ring", "coin"], default="gold_ingot")
    parser.add_argument("--preset", choices=list(ORO_PBR_PRESETS.keys()), default="gold_24k")
    parser.add_argument("--output", default="assets/models/oro_product_gold.glb")
    parser.add_argument("--name", default="Lingote de Oro ORO")
    
    args = parser.parse_args()

    if args.action in ["generate_prompt", "all"]:
        payload = generate_meshy_task_payload(["images/logo.png"], args.name)
        prompt_file = "tools/last_ai_3d_prompt.json"
        os.makedirs("tools", exist_ok=True)
        with open(prompt_file, "w", encoding="utf-8") as f:
            json.dump(payload, f, indent=2, ensure_ascii=False)
        print(f"[*] Prompt de conversión IA guardado en: {prompt_file}")
        print("\n=== PROMPT PARA CONVERTIR IMÁGENES A 3D CON IA ===")
        print(PROMPT_TEMPLATE)
        print("===================================================\n")

    if args.action in ["create_glb", "all"]:
        create_procedural_oro_glb(args.output, model_type=args.type, preset_name=args.preset)

if __name__ == "__main__":
    main()
