#!/usr/bin/env python3
"""
Automated background removal tool for all ORO ecommerce image assets.
Turns solid/near-white and opaque background pixels into 100% transparent RGBA pixels.
"""

import os
from PIL import Image

def make_transparent(input_path, output_path=None, threshold=238):
    if output_path is None:
        output_path = input_path
    
    if not os.path.exists(input_path):
        return

    img = Image.open(input_path).convert("RGBA")
    datas = img.getdata()
    
    new_data = []
    for item in datas:
        r, g, b, a = item
        # Si el pixel es blanco o casi blanco (fondo de estudio/cuadrícula)
        if r >= threshold and g >= threshold and b >= threshold:
            # Transparencia total
            new_data.append((255, 255, 255, 0))
        elif r >= (threshold - 15) and g >= (threshold - 15) and b >= (threshold - 15):
            # Suavizado de bordes anti-aliasing
            alpha = int(255 * (1.0 - (min(r, g, b) - (threshold - 15)) / 15.0))
            new_data.append((r, g, b, min(a, alpha)))
        else:
            new_data.append(item)

    img.putdata(new_data)
    img.save(output_path, "PNG")
    print(f"[OK] Fondo transparente aplicado a: {output_path}")

def process_all_assets():
    target_files = [
        "images/def.png",
        "images/defx.png",
        "images/authforgotpassword.png",
        "images/onboardingimage1.png",
        "images/onboardingimage2.png",
        "images/onboardingimage3.png",
        "images/onboardingimage4.png",
        "images/HomeCard.png",
        "images/luncher.png",
        "assets/images/HomeCard.png"
    ]
    
    for f in target_files:
        if os.path.exists(f):
            make_transparent(f)

if __name__ == "__main__":
    process_all_assets()
