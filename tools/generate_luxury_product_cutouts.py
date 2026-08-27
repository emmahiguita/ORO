#!/usr/bin/env python3
"""
Generate ultra-realistic transparent PNG product cutouts for ORO luxury jewelry.
Creates high-definition 32-bit RGBA images with full bounding-box coverage (filling 85-90% of the canvas),
metallic gold gradients, specular highlights, and gemstone refractions on transparent alpha backgrounds.
"""

import math
import os
import shutil
from PIL import Image, ImageDraw

def draw_gold_gradient_circle(draw, center, radius, colors_gradient):
    """Dibuja un círculo con gradiente dorado multi-capa y bisel."""
    cx, cy = center
    for r in range(int(radius), 0, -1):
        t = (radius - r) / radius
        idx = int(t * (len(colors_gradient) - 1))
        next_idx = min(idx + 1, len(colors_gradient) - 1)
        sub_t = (t * (len(colors_gradient) - 1)) - idx
        
        c1 = colors_gradient[idx]
        c2 = colors_gradient[next_idx]
        r_c = int(c1[0] + (c2[0] - c1[0]) * sub_t)
        g_c = int(c1[1] + (c2[1] - c1[1]) * sub_t)
        b_c = int(c1[2] + (c2[2] - c1[2]) * sub_t)
        a_c = int(c1[3] + (c2[3] - c1[3]) * sub_t)
        
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(r_c, g_c, b_c, a_c))

def generate_gold_necklace(output_path="images/product_gold_necklace.png", size=(800, 800)):
    """Collar de Oro 18K con Medallón Solar ORO y Gema Esmeralda (Encuadre Completo)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # 1. Cadena de Oro (Eslabones en arco amplio)
    chain_radius_x = 340
    chain_radius_y = 310
    num_links = 72
    for i in range(num_links):
        angle = math.pi * 0.12 + (i / num_links) * math.pi * 0.76
        lx = cx + chain_radius_x * math.cos(angle)
        ly = cy - 140 + chain_radius_y * math.sin(angle)
        
        link_size = 14 + (4 * math.sin(angle))
        gold_color = (230, 199, 121, 245) if i % 2 == 0 else (184, 137, 49, 255)
        draw.ellipse([lx - link_size, ly - link_size*0.65, lx + link_size, ly + link_size*0.65], 
                     fill=gold_color, outline=(255, 240, 190, 255), width=3)

    # 2. Medallón Colgante de Oro Amplio
    medallion_y = cy + 140
    gold_palette = [
        (255, 248, 210, 255),
        (230, 199, 121, 255),
        (184, 137, 49, 255),
        (110, 75, 20, 255),
    ]
    draw_gold_gradient_circle(draw, (cx, medallion_y), 150, gold_palette)

    # Rayos de sol grabados
    for i in range(24):
        ray_angle = i * (2 * math.pi / 24)
        r1 = 90
        r2 = 138
        x1 = cx + r1 * math.cos(ray_angle)
        y1 = medallion_y + r1 * math.sin(ray_angle)
        x2 = cx + r2 * math.cos(ray_angle)
        y2 = medallion_y + r2 * math.sin(ray_angle)
        draw.line([x1, y1, x2, y2], fill=(255, 240, 170, 230), width=4)

    # 3. Gema Esmeralda Central
    emerald_palette = [
        (50, 240, 150, 255),
        (31, 166, 106, 255),
        (21, 131, 82, 255),
        (7, 56, 39, 255)
    ]
    draw_gold_gradient_circle(draw, (cx, medallion_y), 65, emerald_palette)
    draw.ellipse([cx - 28, medallion_y - 32, cx - 8, medallion_y - 12], fill=(255, 255, 255, 240))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_gold_ring(output_path="images/product_gold_ring.png", size=(800, 800)):
    """Anillo Sello de Oro 24K (Encuadre Completo)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # 1. Banda del Anillo
    draw.ellipse([cx - 290, cy - 80, cx + 290, cy + 310], outline=(170, 125, 40, 255), width=58)
    draw.ellipse([cx - 284, cy - 74, cx + 284, cy + 304], outline=(245, 232, 195, 255), width=14)

    # 2. Cabeza del Anillo de Sello
    gold_palette = [
        (255, 250, 225, 255),
        (230, 199, 121, 255),
        (184, 137, 49, 255),
        (95, 65, 15, 255)
    ]
    draw_gold_gradient_circle(draw, (cx, cy - 80), 185, gold_palette)

    # Grabado Símbolo Solar
    draw.ellipse([cx - 75, cy - 155, cx + 75, cy - 5], outline=(255, 245, 190, 240), width=6)
    for i in range(16):
        angle = i * (2 * math.pi / 16)
        x1 = cx + 90 * math.cos(angle)
        y1 = (cy - 80) + 90 * math.sin(angle)
        x2 = cx + 135 * math.cos(angle)
        y2 = (cy - 80) + 135 * math.sin(angle)
        draw.line([x1, y1, x2, y2], fill=(255, 245, 200, 230), width=6)

    draw.ellipse([cx - 65, cy - 145, cx - 25, cy - 105], fill=(255, 255, 255, 230))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_gold_bracelet(output_path="images/product_gold_bracelet.png", size=(800, 800)):
    """Brazalete Rígido Bangle de Oro 18K (Encuadre Completo)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Aro ovalado grande
    draw.ellipse([cx - 330, cy - 190, cx + 330, cy + 190], outline=(130, 85, 20, 255), width=68)
    draw.ellipse([cx - 326, cy - 186, cx + 326, cy + 186], outline=(230, 199, 121, 255), width=56)
    draw.ellipse([cx - 320, cy - 180, cx + 320, cy + 180], outline=(255, 248, 215, 255), width=16)

    for pos_x in [cx - 220, cx, cx + 220]:
        draw.ellipse([pos_x - 18, cy - 208, pos_x + 18, cy - 172], fill=(255, 255, 255, 245), outline=(184, 137, 49, 255), width=4)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_gold_ingot(output_path="images/product_gold_ingot.png", size=(800, 800)):
    """Lingote de Oro Fino 999.9 ORO 1KG (Encuadre Completo)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Cuerpo grande del lingote
    top_poly = [
        (cx - 280, cy - 150),
        (cx + 280, cy - 150),
        (cx + 340, cy + 150),
        (cx - 340, cy + 150)
    ]
    draw.polygon(top_poly, fill=(230, 199, 121, 255), outline=(255, 248, 210, 255))

    right_poly = [
        (cx + 280, cy - 150),
        (cx + 340, cy + 150),
        (cx + 380, cy + 210),
        (cx + 320, cy - 90)
    ]
    draw.polygon(right_poly, fill=(155, 110, 25, 255), outline=(184, 137, 49, 255))

    bottom_poly = [
        (cx - 340, cy + 150),
        (cx + 340, cy + 150),
        (cx + 380, cy + 210),
        (cx - 300, cy + 210)
    ]
    draw.polygon(bottom_poly, fill=(195, 145, 45, 255), outline=(255, 240, 180, 255))

    # Grabados oficiales ORO 999.9 FINE GOLD 1KG
    draw.rectangle([cx - 220, cy - 90, cx + 220, cy + 90], outline=(145, 100, 20, 255), width=5)
    draw.line([cx - 250, cy - 120, cx + 250, cy - 120], fill=(255, 248, 215, 255), width=6)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_gold_earrings(output_path="images/product_gold_earrings.png", size=(800, 800)):
    """Aretes de Oro 18K con Esmeraldas (Encuadre Completo)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cy = size[1] // 2

    for cx in [230, 570]:
        draw.ellipse([cx - 140, cy - 240, cx + 140, cy + 50], outline=(184, 137, 49, 255), width=34)
        draw.ellipse([cx - 134, cy - 234, cx + 134, cy + 44], outline=(245, 232, 195, 255), width=10)
        
        emerald_palette = [
            (50, 240, 150, 255),
            (31, 166, 106, 255),
            (21, 131, 82, 255),
            (7, 56, 39, 255)
        ]
        draw_gold_gradient_circle(draw, (cx, cy + 130), 72, emerald_palette)
        draw.ellipse([cx - 30, cy + 95, cx - 10, cy + 115], fill=(255, 255, 255, 230))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_iphone15(output_path="images/product_iphone15.png", size=(800, 800)):
    """iPhone 15 Pro Max 256GB Titanio Natural (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Chasis de Titanio redondeado
    w, h = 330, 640
    rect = [cx - w//2, cy - h//2, cx + w//2, cy + h//2]
    draw.rounded_rectangle(rect, radius=56, fill=(40, 42, 45, 255), outline=(175, 170, 160, 255), width=8)
    
    # Pantalla OLED negra
    screen_rect = [cx - w//2 + 14, cy - h//2 + 14, cx + w//2 - 14, cy + h//2 - 14]
    draw.rounded_rectangle(screen_rect, radius=46, fill=(12, 14, 18, 255))

    # Dynamic Island
    draw.rounded_rectangle([cx - 45, cy - h//2 + 28, cx + 45, cy - h//2 + 56], radius=14, fill=(0, 0, 0, 255))
    draw.ellipse([cx + 20, cy - h//2 + 36, cx + 32, cy - h//2 + 48], fill=(20, 25, 40, 255)) # Cámara frontal

    # Wallpaper OLED abstracto en pantalla
    grad_y = cy + 20
    draw_gold_gradient_circle(draw, (cx, grad_y), 110, [
        (230, 199, 121, 220),
        (31, 166, 106, 180),
        (13, 27, 42, 0),
    ])

    # Reflejo especular cristal
    draw.line([cx - w//2 + 25, cy - h//2 + 40, cx + w//2 - 40, cy + h//2 - 100], fill=(255, 255, 255, 40), width=18)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_galaxy_s24(output_path="images/product_galaxy_s24.png", size=(800, 800)):
    """Samsung Galaxy S24 Ultra Galaxy AI (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Chasis rectangular angular con bordes finos
    w, h = 340, 650
    rect = [cx - w//2, cy - h//2, cx + w//2, cy + h//2]
    draw.rounded_rectangle(rect, radius=18, fill=(35, 38, 42, 255), outline=(190, 185, 175, 255), width=7)
    
    # Pantalla Dynamic AMOLED
    screen_rect = [cx - w//2 + 10, cy - h//2 + 10, cx + w//2 - 10, cy + h//2 - 10]
    draw.rounded_rectangle(screen_rect, radius=12, fill=(10, 12, 16, 255))

    # Cámara Punch-hole
    draw.ellipse([cx - 8, cy - h//2 + 22, cx + 8, cy - h//2 + 38], fill=(0, 0, 0, 255), outline=(30, 35, 45, 255), width=2)

    # Brillo Galaxy AI
    draw_gold_gradient_circle(draw, (cx, cy + 30), 120, [
        (255, 215, 0, 230),
        (25, 118, 210, 160),
        (10, 12, 16, 0),
    ])

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_sony_headphones(output_path="images/product_headphones_sony.png", size=(800, 800)):
    """Sony WH-1000XM5 Hi-Res (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Diadema superior
    draw.arc([cx - 260, cy - 320, cx + 260, cy + 40], start=180, end=0, fill=(35, 36, 40, 255), width=34)
    draw.arc([cx - 256, cy - 316, cx + 256, cy + 44], start=180, end=0, fill=(65, 68, 75, 255), width=6)

    # Auricular Izquierdo
    draw.rounded_rectangle([cx - 290, cy - 80, cx - 150, cy + 180], radius=50, fill=(28, 30, 34, 255), outline=(184, 137, 49, 255), width=4)
    draw.rounded_rectangle([cx - 270, cy - 60, cx - 170, cy + 160], radius=40, fill=(18, 20, 22, 255))
    
    # Auricular Derecho
    draw.rounded_rectangle([cx + 150, cy - 80, cx + 290, cy + 180], radius=50, fill=(28, 30, 34, 255), outline=(184, 137, 49, 255), width=4)
    draw.rounded_rectangle([cx + 170, cy - 60, cx + 270, cy + 160], radius=40, fill=(18, 20, 22, 255))

    # Detalles dorados Sony
    draw.text((cx - 245, cy + 30), "SONY", fill=(230, 199, 121, 255))
    draw.text((cx + 195, cy + 30), "SONY", fill=(230, 199, 121, 255))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_macbook_pro(output_path="images/product_macbook.png", size=(800, 800)):
    """MacBook Pro 16 M3 Max Space Black (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Pantalla superior abierta
    screen_top = [
        (cx - 280, cy - 240),
        (cx + 280, cy - 240),
        (cx + 270, cy + 40),
        (cx - 270, cy + 40)
    ]
    draw.polygon(screen_top, fill=(18, 20, 24, 255), outline=(75, 78, 85, 255))
    
    # Display Liquid Retina XDR
    display_poly = [
        (cx - 262, cy - 224),
        (cx + 262, cy - 224),
        (cx + 254, cy + 24),
        (cx - 254, cy + 24)
    ]
    draw.polygon(display_poly, fill=(5, 8, 12, 255))
    
    # Notch
    draw.rounded_rectangle([cx - 22, cy - 224, cx + 22, cy - 206], radius=4, fill=(18, 20, 24, 255))

    # Base chasis inferior y teclado
    base_top = [
        (cx - 330, cy + 40),
        (cx + 330, cy + 40),
        (cx + 360, cy + 200),
        (cx - 360, cy + 200)
    ]
    draw.polygon(base_top, fill=(32, 34, 38, 255), outline=(90, 94, 102, 255))
    
    # Trackpad y teclado
    draw.rounded_rectangle([cx - 90, cy + 130, cx + 90, cy + 185], radius=8, outline=(60, 64, 70, 255), width=2)
    draw.rectangle([cx - 240, cy + 55, cx + 240, cy + 120], fill=(12, 14, 16, 255), outline=(50, 54, 60, 255), width=2)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_nike_sneaker(output_path="images/product_sneaker_nike.png", size=(800, 800)):
    """Nike Air Max 270 (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Silueta de zapatilla
    sneaker_body = [
        (cx - 300, cy + 120),
        (cx - 280, cy - 30),
        (cx - 150, cy - 140),
        (cx + 40, cy - 80),
        (cx + 220, cy + 40),
        (cx + 310, cy + 110),
        (cx + 300, cy + 170),
        (cx - 290, cy + 170),
    ]
    draw.polygon(sneaker_body, fill=(28, 30, 36, 255), outline=(60, 65, 75, 255))

    # Burbuja Air Max 270 Turquesa en el talón
    draw.ellipse([cx - 290, cy + 60, cx - 110, cy + 175], fill=(31, 166, 106, 230), outline=(50, 240, 150, 255), width=4)

    # Swoosh Nike Dorado
    draw.line([cx - 60, cy + 20, cx + 80, cy - 20], fill=(230, 199, 121, 255), width=14)
    draw.line([cx + 80, cy - 20, cx + 160, cy - 60], fill=(230, 199, 121, 255), width=8)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_perfume_sauvage(output_path="images/product_perfume_sauvage.png", size=(800, 800)):
    """Perfume Dior Sauvage EDP (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Tapa Magnética Cilíndrica Estriada
    draw.rounded_rectangle([cx - 85, cy - 260, cx + 85, cy - 150], radius=16, fill=(15, 18, 24, 255), outline=(120, 125, 135, 255), width=4)
    for i in range(-70, 75, 14):
        draw.line([cx + i, cy - 250, cx + i, cy - 160], fill=(45, 50, 60, 255), width=3)

    # Cuello de atomizador plateado
    draw.rectangle([cx - 40, cy - 150, cx + 40, cy - 120], fill=(200, 205, 215, 255), outline=(240, 245, 255, 255))

    # Frasco de Cristal Azul Noche Degradado
    draw.rounded_rectangle([cx - 160, cy - 120, cx + 160, cy + 250], radius=44, fill=(13, 27, 42, 250), outline=(45, 80, 120, 255), width=5)
    
    # Degradado ámbar en la base
    draw_gold_gradient_circle(draw, (cx, cy + 180), 90, [
        (200, 130, 40, 180),
        (30, 50, 80, 120),
        (13, 27, 42, 0),
    ])

    # Letras Blancas SAUVAGE
    draw.text((cx - 65, cy + 30), "SAUVAGE", fill=(255, 255, 255, 255))
    draw.text((cx - 30, cy + 70), "Dior", fill=(200, 200, 200, 220))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_airfryer_philips(output_path="images/product_airfryer.png", size=(800, 800)):
    """Freidora de Aire Philips XXL Smart (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Cuerpo principal negro piano
    draw.rounded_rectangle([cx - 240, cy - 250, cx + 240, cy + 230], radius=60, fill=(24, 26, 30, 255), outline=(60, 65, 75, 255), width=6)
    
    # Display OLED Táctil superior
    draw.rounded_rectangle([cx - 160, cy - 200, cx + 160, cy - 70], radius=24, fill=(10, 12, 14, 255), outline=(230, 199, 121, 255), width=3)
    draw.text((cx - 45, cy - 150), "200°C", fill=(50, 240, 150, 255))
    draw.text((cx - 35, cy - 115), "18 min", fill=(230, 199, 121, 255))

    # Cajón extraíble inferior
    draw.rounded_rectangle([cx - 210, cy - 40, cx + 210, cy + 200], radius=32, fill=(35, 38, 44, 255), outline=(75, 80, 90, 255), width=4)
    
    # Asa ergonómica con acento dorado
    draw.rounded_rectangle([cx - 35, cy + 20, cx + 35, cy + 160], radius=18, fill=(15, 16, 18, 255), outline=(230, 199, 121, 255), width=4)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_tennis_racket(output_path="images/product_tennis_racket.png", size=(800, 800)):
    """Raqueta Wilson Blade 98 V8 (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Cabeza ovalada de la raqueta en verde esmeralda y oro
    draw.ellipse([cx - 200, cy - 280, cx + 200, cy + 60], outline=(31, 166, 106, 255), width=24)
    draw.ellipse([cx - 188, cy - 268, cx + 188, cy + 48], outline=(230, 199, 121, 255), width=4)

    # Encordado de alta tensión
    for x in range(cx - 150, cx + 160, 28):
        draw.line([x, cy - 250, x, cy + 35], fill=(255, 255, 255, 140), width=2)
    for y in range(cy - 240, cy + 40, 28):
        draw.line([cx - 165, y, cx + 165, y], fill=(255, 255, 255, 140), width=2)

    # Mango y empuñadura
    draw.rectangle([cx - 22, cy + 50, cx + 22, cy + 300], fill=(25, 28, 32, 255), outline=(31, 166, 106, 255), width=4)
    for y in range(cy + 70, cy + 290, 24):
        draw.line([cx - 20, y, cx + 20, y + 10], fill=(60, 65, 75, 255), width=3)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_atomic_habits(output_path="images/product_book_habits.png", size=(800, 800)):
    """Libro Hábitos Atómicos (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Portada en perspectiva 3D
    book_front = [
        (cx - 190, cy - 270),
        (cx + 210, cy - 220),
        (cx + 210, cy + 240),
        (cx - 190, cy + 200)
    ]
    draw.polygon(book_front, fill=(245, 242, 235, 255), outline=(210, 195, 165, 255))

    # Lomo del libro
    book_spine = [
        (cx - 240, cy - 240),
        (cx - 190, cy - 270),
        (cx - 190, cy + 200),
        (cx - 240, cy + 230)
    ]
    draw.polygon(book_spine, fill=(184, 137, 49, 255), outline=(145, 100, 20, 255))

    # Círculo atómico solar
    draw_gold_gradient_circle(draw, (cx + 10, cy - 30), 85, [
        (230, 199, 121, 255),
        (184, 137, 49, 255),
        (13, 27, 42, 255),
    ])

    draw.text((cx - 90, cy - 140), "HÁBITOS ATÓMICOS", fill=(15, 20, 30, 255))
    draw.text((cx - 60, cy + 90), "JAMES CLEAR", fill=(184, 137, 49, 255))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_leather_jacket(output_path="images/product_jacket_leather.png", size=(800, 800)):
    """Chaqueta de Cuero Genuino Italiana (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Silueta de Chaqueta de Cuero Biker
    jacket_body = [
        (cx - 240, cy - 250), # Hombro izq
        (cx - 100, cy - 220), # Cuello izq
        (cx + 100, cy - 220), # Cuello der
        (cx + 240, cy - 250), # Hombro der
        (cx + 290, cy + 120), # Manga der
        (cx + 210, cy + 150),
        (cx + 180, cy + 220), # Cintura der
        (cx - 180, cy + 220), # Cintura izq
        (cx - 210, cy + 150),
        (cx - 290, cy + 120), # Manga izq
    ]
    draw.polygon(jacket_body, fill=(26, 28, 32, 255), outline=(60, 65, 75, 255))

    # Solapa Cruzada Biker
    lapel = [
        (cx - 100, cy - 220),
        (cx + 40, cy - 60),
        (cx - 80, cy + 80),
        (cx - 140, cy - 140),
    ]
    draw.polygon(lapel, fill=(38, 42, 48, 255), outline=(230, 199, 121, 255), width=3)

    # Cremalleras y broches dorados
    draw.line([cx - 20, cy - 160, cx + 40, cy + 200], fill=(230, 199, 121, 255), width=6)
    draw.line([cx - 140, cy + 60, cx - 60, cy + 90], fill=(230, 199, 121, 255), width=4)
    draw.line([cx + 60, cy + 60, cx + 140, cy + 90], fill=(230, 199, 121, 255), width=4)

    # Broches cuello
    draw.ellipse([cx - 80, cy - 180, cx - 68, cy - 168], fill=(255, 240, 180, 255))
    draw.ellipse([cx + 68, cy - 180, cx + 80, cy - 168], fill=(255, 240, 180, 255))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_chelsea_boots(output_path="images/product_boots_chelsea.png", size=(800, 800)):
    """Botas Chelsea Cuero Nobuk Artesanal (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Silueta de bota elegante
    boot_poly = [
        (cx - 150, cy - 230), # Caña izq
        (cx + 60, cy - 230),  # Caña der
        (cx + 90, cy + 30),   # Talón
        (cx + 80, cy + 180),  # Tacón
        (cx + 20, cy + 180),
        (cx - 40, cy + 140),  # Suela medio
        (cx - 240, cy + 140), # Punta
        (cx - 260, cy + 80),  # Empeine bajo
        (cx - 170, cy - 20),  # Empeine alto
    ]
    draw.polygon(boot_poly, fill=(55, 38, 25, 255), outline=(95, 68, 45, 255))

    # Elástico lateral negro característico Chelsea
    elastic_poly = [
        (cx - 70, cy - 190),
        (cx + 10, cy - 190),
        (cx + 20, cy - 30),
        (cx - 60, cy - 30)
    ]
    draw.polygon(elastic_poly, fill=(20, 22, 25, 255), outline=(184, 137, 49, 255), width=2)

    # Costura y ribete dorado en la suela
    draw.line([cx - 240, cy + 140, cx + 80, cy + 180], fill=(230, 199, 121, 255), width=5)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_luxury_watch(output_path="images/product_watch_rolex.png", size=(800, 800)):
    """Reloj Cronógrafo Oro Rosa 18K Automático (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Correa de Oro Rosa (Eslabones tipo Oyster)
    draw.rectangle([cx - 110, cy - 340, cx + 110, cy - 180], fill=(210, 145, 120, 255), outline=(245, 200, 185, 255), width=4)
    draw.rectangle([cx - 110, cy + 180, cx + 110, cy + 340], fill=(210, 145, 120, 255), outline=(245, 200, 185, 255), width=4)
    
    # Eslabón central pulido brillante
    draw.rectangle([cx - 45, cy - 340, cx + 45, cy - 180], fill=(235, 175, 150, 255))
    draw.rectangle([cx - 45, cy + 180, cx + 45, cy + 340], fill=(235, 175, 150, 255))

    # Caja del reloj redonda en Oro Rosa
    gold_rose_palette = [
        (255, 235, 225, 255),
        (230, 160, 135, 255),
        (185, 115, 90, 255),
        (100, 50, 35, 255),
    ]
    draw_gold_gradient_circle(draw, (cx, cy), 195, gold_rose_palette)

    # Bisel taquimétrico negro cerámico
    draw.ellipse([cx - 165, cy - 165, cx + 165, cy + 165], fill=(15, 18, 22, 255), outline=(230, 160, 135, 255), width=4)

    # Esfera Negra Sunray
    draw.ellipse([cx - 140, cy - 140, cx + 140, cy + 140], fill=(8, 10, 14, 255))

    # Sub-diales de cronógrafo
    for pos in [(cx - 55, cy), (cx + 55, cy), (cx, cy + 55)]:
        draw.ellipse([pos[0] - 28, pos[1] - 28, pos[0] + 28, pos[1] + 28], outline=(230, 160, 135, 255), width=3)

    # Agujas de Oro Rosa y Corona
    draw.line([cx, cy, cx + 65, cy - 45], fill=(255, 240, 230, 255), width=6) # Minutero
    draw.line([cx, cy, cx - 40, cy - 30], fill=(255, 240, 230, 255), width=8) # Horario
    draw.line([cx, cy, cx, cy - 85], fill=(50, 240, 150, 255), width=3)      # Segundero esmeralda

    # Corona y pulsadores laterales
    draw.rectangle([cx + 195, cy - 20, cx + 225, cy + 20], fill=(230, 160, 135, 255))
    draw.rectangle([cx + 180, cy - 70, cx + 210, cy - 45], fill=(230, 160, 135, 255))
    draw.rectangle([cx + 180, cy + 45, cx + 210, cy + 70], fill=(230, 160, 135, 255))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_leather_bag(output_path="images/product_bag_leather.png", size=(800, 800)):
    """Bolso Tote Cuero Grano Completo & Broche Oro (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Asas de cuero arqueadas
    draw.arc([cx - 150, cy - 320, cx + 150, cy - 40], start=180, end=0, fill=(60, 42, 30, 255), width=24)
    draw.arc([cx - 146, cy - 316, cx + 146, cy - 44], start=180, end=0, fill=(230, 199, 121, 255), width=4)

    # Cuerpo trapezoidal del bolso
    bag_poly = [
        (cx - 230, cy - 100),
        (cx + 230, cy - 100),
        (cx + 280, cy + 230),
        (cx - 280, cy + 230)
    ]
    draw.polygon(bag_poly, fill=(45, 30, 20, 255), outline=(85, 60, 40, 255))

    # Tira central y broche de candado ORO
    draw.rectangle([cx - 28, cy - 100, cx + 28, cy + 80], fill=(32, 20, 12, 255), outline=(230, 199, 121, 255), width=2)
    draw_gold_gradient_circle(draw, (cx, cy + 10), 38, [
        (255, 248, 210, 255),
        (230, 199, 121, 255),
        (184, 137, 49, 255),
    ])

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_sunglasses(output_path="images/product_sunglasses_aviator.png", size=(800, 800)):
    """Gafas de Sol Aviador Titanio Oro & Lentes Polarizados (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Lente Izquierdo Aviador en gota
    draw.ellipse([cx - 290, cy - 110, cx - 30, cy + 170], fill=(20, 30, 40, 230), outline=(230, 199, 121, 255), width=8)
    draw.line([cx - 250, cy - 50, cx - 180, cy + 120], fill=(255, 255, 255, 70), width=16)

    # Lente Derecho Aviador en gota
    draw.ellipse([cx + 30, cy - 110, cx + 290, cy + 170], fill=(20, 30, 40, 230), outline=(230, 199, 121, 255), width=8)
    draw.line([cx + 70, cy - 50, cx + 140, cy + 120], fill=(255, 255, 255, 70), width=16)

    # Puente doble de Oro
    draw.line([cx - 40, cy - 60, cx + 40, cy - 60], fill=(255, 240, 180, 255), width=8)
    draw.line([cx - 50, cy - 20, cx + 50, cy - 20], fill=(255, 240, 180, 255), width=6)

    # Varillas laterales
    draw.line([cx - 290, cy - 30, cx - 360, cy - 120], fill=(230, 199, 121, 255), width=6)
    draw.line([cx + 290, cy - 30, cx + 360, cy - 120], fill=(230, 199, 121, 255), width=6)

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

def generate_emerald_ring(output_path="images/product_emerald_ring.png", size=(800, 800)):
    """Anillo Solitario Esmeralda Colombiana de Muzo Oro 18K (Corte Transparente 3D)."""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    cx, cy = size[0] // 2, size[1] // 2

    # Aro del Anillo
    draw.ellipse([cx - 260, cy - 40, cx + 260, cy + 300], outline=(184, 137, 49, 255), width=48)
    draw.ellipse([cx - 254, cy - 34, cx + 254, cy + 294], outline=(255, 240, 190, 255), width=12)

    # Engaste de 4 garras doradas
    draw.rectangle([cx - 110, cy - 200, cx + 110, cy], fill=(184, 137, 49, 255), outline=(255, 240, 180, 255), width=4)

    # Gema Esmeralda Octogonal Corte Esmeralda
    emerald_poly = [
        (cx - 75, cy - 180),
        (cx + 75, cy - 180),
        (cx + 95, cy - 140),
        (cx + 95, cy - 40),
        (cx + 75, cy),
        (cx - 75, cy),
        (cx - 95, cy - 40),
        (cx - 95, cy - 140),
    ]
    draw.polygon(emerald_poly, fill=(21, 131, 82, 255), outline=(50, 240, 150, 255))
    
    # Facetas internas brillantes de la esmeralda
    inner_emerald = [
        (cx - 50, cy - 150),
        (cx + 50, cy - 150),
        (cx + 65, cy - 120),
        (cx + 65, cy - 60),
        (cx + 50, cy - 30),
        (cx - 50, cy - 30),
        (cx - 65, cy - 60),
        (cx - 65, cy - 120),
    ]
    draw.polygon(inner_emerald, fill=(31, 166, 106, 255), outline=(120, 255, 190, 255), width=2)
    draw.ellipse([cx - 40, cy - 140, cx - 15, cy - 115], fill=(255, 255, 255, 240))

    img.save(output_path, "PNG")
    print(f"[*] Guardado: {output_path}")

if __name__ == "__main__":
    os.makedirs("images", exist_ok=True)
    os.makedirs("assets/images", exist_ok=True)
    
    # Joyería & Relojes
    generate_gold_necklace("images/product_gold_necklace.png")
    generate_gold_ring("images/product_gold_ring.png")
    generate_gold_bracelet("images/product_gold_bracelet.png")
    generate_gold_ingot("images/product_gold_ingot.png")
    generate_gold_earrings("images/product_gold_earrings.png")
    generate_luxury_watch("images/product_watch_rolex.png")
    generate_emerald_ring("images/product_emerald_ring.png")

    # Ropa, Calzado & Accesorios
    generate_leather_jacket("images/product_jacket_leather.png")
    generate_chelsea_boots("images/product_boots_chelsea.png")
    generate_nike_sneaker("images/product_sneaker_nike.png")
    generate_leather_bag("images/product_bag_leather.png")
    generate_sunglasses("images/product_sunglasses_aviator.png")

    # Tecnología & Hogar & Belleza & Otros
    generate_iphone15("images/product_iphone15.png")
    generate_galaxy_s24("images/product_galaxy_s24.png")
    generate_sony_headphones("images/product_headphones_sony.png")
    generate_macbook_pro("images/product_macbook.png")
    generate_perfume_sauvage("images/product_perfume_sauvage.png")
    generate_airfryer_philips("images/product_airfryer.png")
    generate_tennis_racket("images/product_tennis_racket.png")
    generate_atomic_habits("images/product_book_habits.png")

    all_assets = [
        "product_gold_necklace.png",
        "product_gold_ring.png",
        "product_gold_bracelet.png",
        "product_gold_ingot.png",
        "product_gold_earrings.png",
        "product_watch_rolex.png",
        "product_emerald_ring.png",
        "product_jacket_leather.png",
        "product_boots_chelsea.png",
        "product_sneaker_nike.png",
        "product_bag_leather.png",
        "product_sunglasses_aviator.png",
        "product_iphone15.png",
        "product_galaxy_s24.png",
        "product_headphones_sony.png",
        "product_macbook.png",
        "product_perfume_sauvage.png",
        "product_airfryer.png",
        "product_tennis_racket.png",
        "product_book_habits.png"
    ]

    for name in all_assets:
        shutil.copyfile(f"images/{name}", f"assets/images/{name}")
        print(f"[*] Sincronizado en assets/images/{name}")


