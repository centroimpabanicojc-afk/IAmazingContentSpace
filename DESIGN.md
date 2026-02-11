# Design System: IAmazing Content Studio
**Project ID:** iamazing-production-v2

## 1. Visual Theme & Atmosphere
El diseño sigue una estética **"Glassmorphism Premium"** con una vibración cibernética y profesional. La atmósfera es de alta densidad operativa (especialmente en el dashboard) pero mantenida bajo una filosofía minimalista y centrada en la IA (impulsada por Cortex). Se prioriza el contraste profundo y los acentos vibrantes para guiar el ojo hacia la acción.

## 2. Color Palette & Roles
- **Deep Obsidian Black (#020617)**: Fondo base de la aplicación. `var(--bg-dark)`
- **Midnight Slate Card (#0f172a)**: Superficie de las tarjetas. `var(--bg-surface)`
- **Cyber Violet (#8b5cf6)**: Acento primario. `var(--accent-primary)`
- **Neon Cyan (#06b6d4)**: Acento secundario. `var(--accent-secondary)`
- **Pure White (#f8fafc)**: Texto primario. `var(--text-primary)`
- **Cool Slate Gray (#94a3b8)**: Texto secundario. `var(--text-secondary)`

### CSS Variables Reference
```css
:root {
    --bg-dark: #020617;
    --bg-surface: rgba(15, 23, 42, 0.6); /* Slightly transparent with glass class */
    --accent-primary: #8b5cf6;
    --accent-secondary: #06b6d4;
    --accent-glow: rgba(139, 92, 246, 0.4);
    --text-primary: #f8fafc;
    --text-secondary: #94a3b8;
    --glass-border: rgba(255, 255, 255, 0.08);
    --radius-xl: 40px;
}
```

## 3. Typography Rules
- **Font Family**: 'Inter' o 'Outfit' (Sans-serif modernas).
- **Headings**: Extra-bold/Black (900) con tracking tight (-0.02em) para un look editorial premium.
- **Body**: Regular/Medium (400-500) para legibilidad en entornos de datos densos.

## 4. Component Stylings
* **Botones**: 
    - **Primarios**: Fondo Violet-600, bordes redondeados de 12px-16px, sombra violeta difusa.
    - **Glass**: Fondo blanco con 3-5% de opacidad, desenfoque de fondo de 12px.
* **Cards/Containers**: 
    - Bordes generosamente redondeados (`rounded-[40px]`).
    - Borde sutil de 1px (`rgba(255, 255, 255, 0.08)`).
    - Backdrop-blur de 12px a 16px.
* **Inputs/Forms**: 
    - Fondo negro con 20% opacidad.
    - Foco con anillo de 2px en Cyber Violet.

## 5. Layout Principles
- **Densidad Adaptativa**: El dashboard usa un sistema de rejilla denso para control total, mientras que la landing page usa espacios en blanco generosos (padding de 20-40px) para respiración visual.
- **Jerarquía AI**: Los elementos generados o sugeridos por Cortex AI (como el Office Board) tienen un sutil degradado violeta de fondo para destacar su importancia.
