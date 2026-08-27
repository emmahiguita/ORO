# Blender Headless Automation Script for ORO Ecommerce 3D Models
# Run via: blender -b -P tools/blender_pbr_optimizer.py -- input_model.obj output_model.glb

import sys
import os

try:
    import bpy
except ImportError:
    print("[!] Este script está diseñado para ejecutarse dentro del entorno Python de Blender (blender -b -P ...)")
    sys.exit(0)

def clean_scene():
    bpy.ops.wm.read_factory_settings(use_empty=True)

def setup_pbr_gold_material(obj):
    mat = bpy.data.materials.new(name="ORO_PBR_Gold")
    mat.use_nodes = True
    nodes = mat.node_tree.nodes
    links = mat.node_tree.links

    bsdf = nodes.get("Principled BSDF")
    if bsdf:
        # Configuración de Oro 24K
        bsdf.inputs["Base Color"].default_value = (0.90, 0.78, 0.47, 1.0)
        bsdf.inputs["Metallic"].default_value = 1.0
        bsdf.inputs["Roughness"].default_value = 0.15
        bsdf.inputs["Specular IOR Level"].default_value = 0.5

    if obj.data.materials:
        obj.data.materials[0] = mat
    else:
        obj.data.materials.append(mat)

def process_and_export_glb(input_file, output_glb):
    clean_scene()
    
    # Importar modelo
    ext = os.path.splitext(input_file)[1].lower()
    if ext == ".obj":
        bpy.ops.wm.obj_import(filepath=input_file)
    elif ext in [".gltf", ".glb"]:
        bpy.ops.import_scene.gltf(filepath=input_file)
    elif ext == ".fbx":
        bpy.ops.import_scene.fbx(filepath=input_file)
    else:
        print(f"[!] Formato no soportado: {ext}")
        return

    # Seleccionar todos los objetos de malla
    mesh_objs = [o for o in bpy.context.scene.objects if o.type == 'MESH']
    if not mesh_objs:
        print("[!] No se encontraron mallas para exportar.")
        return

    # Centrar punto de pivote en la base inferior
    bpy.ops.object.select_all(action='DESELECT')
    for obj in mesh_objs:
        obj.select_set(True)
        bpy.context.view_layer.objects.active = obj
        bpy.ops.object.origin_set(type='ORIGIN_CENTER_OF_MASS', center='BOUNDS')
        setup_pbr_gold_material(obj)

    # Exportar GLB optimizado para móvil
    os.makedirs(os.path.dirname(os.path.abspath(output_glb)), exist_ok=True)
    bpy.ops.export_scene.gltf(
        filepath=output_glb,
        export_format='GLB',
        export_apply=True,
        export_tangents=True,
        export_materials='EXPORT',
        export_draco_mesh_compression_enable=True
    )
    print(f"[*] Exportado GLB optimizado: {output_glb}")

if __name__ == "__main__":
    args = sys.argv
    if "--" in args:
        user_args = args[args.index("--") + 1:]
        if len(user_args) >= 2:
            process_and_export_glb(user_args[0], user_args[1])
        else:
            print("[!] Uso: blender -b -P tools/blender_pbr_optimizer.py -- input.obj output.glb")
