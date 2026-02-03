# **Arquitectura de lo increíble: Frameworks y tecnologías para la creación de obras de arte digital en la web moderna**

La búsqueda de la herramienta definitiva para la creación de experiencias web que trasciendan la funcionalidad comercial y se ubiquen en el ámbito de la vanguardia artística requiere una comprensión profunda de la intersección entre el hardware gráfico, los modelos matemáticos de representación y la orquestación narrativa.1 En el panorama tecnológico de 2025 y 2026, el navegador se ha transformado en un lienzo de computación paralela masiva, impulsado por la maduración de WebGPU y la consolidación de ecosistemas que permiten a los tecnólogos creativos manipular la realidad digital con una precisión quirúrgica.3 Para responder a la pregunta sobre cuál es la librería o framework más increíble, no es posible señalar una única solución aislada, sino más bien un ecosistema de síntesis donde Three.js, potenciado por el nuevo Three.js Shading Language (TSL), y orquestadores cinemáticos como Theatre.js, definen el estándar de lo que se considera una obra de arte digital única.5

## **El renacimiento del renderizado web: La hegemonía de Three.js y WebGPU**

En el centro del desarrollo web artístico contemporáneo se encuentra Three.js, una librería que ha dominado el ecosistema 3D desde 2010 y que, lejos de estancarse, ha experimentado un renacimiento radical con el soporte nativo para WebGPU.4 La transición de WebGL a WebGPU no es simplemente una actualización de versión; es un cambio de paradigma arquitectónico que alinea el navegador con las API gráficas modernas como Vulkan, Metal y DirectX 12\.9 Para un artista digital, esto significa la eliminación de cuellos de botella históricos en la CPU, permitiendo la gestión de escenas con una complejidad geométrica y de cómputo que anteriormente solo era posible en aplicaciones nativas de escritorio.3

La versión r171 de Three.js, lanzada en septiembre de 2025, marcó un hito al introducir importaciones de WebGPU sin configuración previa, facilitando que cualquier proyecto de vanguardia acceda a capacidades de cómputo masivo de forma transparente.4 Este avance es fundamental para la creación de experiencias "nunca antes vistas", ya que permite integrar simulaciones de física compleja, millones de partículas y técnicas de iluminación global directamente en el hilo de ejecución de la GPU.4

### **Comparativa técnica de motores de renderizado artístico**

Para determinar la herramienta más adecuada, es esencial analizar las diferencias filosóficas y técnicas entre los principales contendientes del mercado. Mientras que Three.js apuesta por una modularidad extrema que favorece la experimentación artística, Babylon.js se presenta como una solución "todo incluido" con un enfoque más cercano al desarrollo de videojuegos tradicionales.8

| Característica | Three.js (Vanguardia Experimental) | Babylon.js (Motor de Juego Completo) | PlayCanvas (Basado en la Nube) |
| :---- | :---- | :---- | :---- |
| **Filosofía** | Minimalista, modular, impulsada por la comunidad 13 | "Baterías incluidas", estructurada, respaldada por Microsoft 11 | Editor visual en el navegador, flujo de trabajo colaborativo 11 |
| **Integración WebGPU** | Nativa y transparente desde r171 4 | Soporte completo con optimizaciones integradas 13 | Soporte experimental enfocado en juegos 11 |
| **Sistema de Shaders** | TSL (Three.js Shading Language) basado en nodos 6 | Node Material Editor (NME) visual 11 | Enfoque tradicional basado en fragmentos y vértices 14 |
| **Ecosistema Artístico** | Dominante (2.7M descargas semanales) 4 | Especializado en simulación y XR empresarial 15 | Equipos creativos y prototipado rápido 11 |
| **Control de Escena** | Bajo nivel, total libertad arquitectónica 16 | Opinado, con gestores de activos integrados 13 | Basado en entidades y componentes (ECS) 14 |

La elección de Three.js como la herramienta más increíble para el arte digital se justifica por su inmenso ecosistema de "tecnologías satélite", como React Three Fiber (R3F), que permite una gestión declarativa de la escena 3D, y Drei, una colección de abstracciones que simplifica tareas complejas como el mapeo de reflejos o la implementación de post-procesamiento avanzado.4

## **La revolución del lenguaje de sombreado: TSL y la computación creativa**

El verdadero vanguardismo en una aplicación artística web suele residir en sus materiales y efectos visuales únicos. Históricamente, escribir shaders personalizados requería dominar GLSL (OpenGL Shading Language), un proceso a menudo desconectado de la lógica de JavaScript y propenso a errores difíciles de depurar.8 Three.js ha resuelto esta fricción con la introducción de TSL (Three.js Shading Language), un lenguaje de sombreado basado en nodos que permite escribir lógica de GPU utilizando sintaxis pura de JavaScript o TypeScript.6

TSL no es solo una capa de abstracción; es un compilador inteligente que traduce la lógica declarativa del artista tanto a GLSL (para compatibilidad con WebGL) como a WGSL (el lenguaje nativo de WebGPU).9 Esto permite que una obra de arte digital mantenga su integridad visual en cualquier dispositivo, aprovechando las capacidades máximas del hardware disponible.7

### **Ventajas estéticas del uso de TSL en proyectos de arte**

La capacidad de TSL para tratar los shaders como funciones modulares permite a los creadores construir grafos de materiales extremadamente complejos. Un artista puede definir una función de ruido procedimental y aplicarla sistemáticamente a través de diferentes canales:

* **Desplazamiento de vértices:** Para crear formas orgánicas que pulsan o se deforman de manera fluida.7  
* **Color emisivo dinámico:** Vinculando el brillo de un objeto a su velocidad o a la proximidad del usuario.18  
* **Efectos de post-procesamiento:** Implementando técnicas como el Bloom, la Oclusión Ambiental o el ruido de grano de película de manera integrada en la tubería de renderizado.18

Esta modularidad elimina la necesidad de manipular cadenas de texto complejas y permite que la intención artística se traduzca directamente en operaciones matemáticas visuales.6 La integración de TSL con el renderizador de WebGPU permite, además, el acceso a Compute Shaders, lo que habilita la ejecución de simulaciones físicas de millones de partículas que antes eran impensables en un entorno web.4

## **Orquestación cinemática: El papel de Theatre.js en la narrativa digital**

Una obra de arte digital única no es solo una imagen estática o una animación en bucle; es una experiencia que posee ritmo, tiempo y evolución narrativa.2 Theatre.js ha emergido como el framework de animación más potente para dotar de una dirección cinemática a las aplicaciones web construidas con Three.js.5

A diferencia de las librerías de animación tradicionales (como Tween.js o Anime.js), Theatre.js proporciona una interfaz de estudio visual que permite a los diseñadores y desarrolladores colaborar en la creación de secuencias complejas directamente en el navegador.5 Esta interfaz permite manipular luces, cámaras, colores de materiales y transformaciones de objetos en una línea de tiempo con edición de curvas de precisión, similar a software profesional como After Effects o Cinema 4D.5

### **Mecanismos de control cinemático en Theatre.js**

| Concepto | Aplicación en Arte Digital | Beneficio Técnico |
| :---- | :---- | :---- |
| **Sheets y Sequences** | Organización de "escenas" o momentos narrativos 5 | Permite orquestar múltiples objetos bajo una sola línea de tiempo 21 |
| **Studio UI** | Edición visual de la estética en tiempo real 20 | Los cambios se guardan en el localStorage del navegador 5 |
| **State.json** | Exportación de la intención creativa a producción 5 | Carga animaciones pre-diseñadas con un impacto mínimo en el código 20 |
| **Compound Props** | Control granular de propiedades agrupadas (pos, rot, scale) 21 | Facilita la creación de movimientos complejos y coordinados 21 |

La capacidad de Theatre.js para "grabar" la interacción humana y traducirla en secuencias de fotogramas clave permite que una aplicación web se sienta como una película interactiva.2 Por ejemplo, en el proyecto "Aurel's Grand Theater", se utilizó una combinación de Three.js, GSAP y VueJs para crear un portafolio poco convencional donde el usuario explora un teatro misterioso, resolviendo acertijos para desbloquear contenido.22 Aunque no cita explícitamente a Theatre.js, la arquitectura de este tipo de proyectos demuestra la necesidad de una orquestación centralizada para lograr una inmersión total.

## **Técnicas de vanguardia: De la simulación de fluidos al Gaussian Splatting**

Para que una aplicación web sea verdaderamente "increíble", a menudo debe incorporar elementos visuales que desafíen la percepción de lo que es posible en tiempo real. Esto incluye simulaciones físicas de alta fidelidad y técnicas de renderizado neural.23

### **Simulaciones físicas y el poder del MPM**

Las simulaciones de fluidos y telas han sido tradicionalmente el dominio de la computación fuera de línea. Sin embargo, estudios como Lusion han demostrado que es posible trasladar estas experiencias a la web utilizando técnicas avanzadas de optimización y precomputación.25 El uso del Material Point Method (MPM) sobre WebGPU permite simulaciones de fluidos estables incluso en ángulos extremos, como se observa en el proyecto WaterBall de Matsuoka\_601.23

Lusion, en particular, utiliza Houdini FX para generar activos personalizados y simulaciones de telas que luego se integran en WebGL/Three.js.25 Una técnica innovadora empleada por este estudio consiste en almacenar datos de simulaciones físicas complejas, como campos de distancia con signo (SDF), en canales de imágenes PNG (RGB para el gradiente de normales y alfa para la distancia).26 Esto permite realizar detecciones de colisiones en la GPU en tiempo real con un consumo de recursos mínimo, permitiendo que la obra de arte funcione en dispositivos móviles.26

### **Gaussian Splatting: La captura fotorrealista de la realidad**

El 3D Gaussian Splatting (3DGS) representa el cambio más significativo en la creación de contenido 3D de los últimos años.24 En lugar de utilizar mallas poligonales, el 3DGS reconstruye escenas a partir de millones de elipsoides de luz que capturan reflejos, transparencias y detalles microscópicos con un fotorrealismo extremo.12

La integración de WebGPU es vital para el éxito del 3DGS en la web, ya que permite realizar el ordenamiento de millones de "splats" por cuadro (radix sort) directamente en la GPU.12 Tecnologías como Visionary han reportado una reducción de hasta 85 veces en el tiempo de renderizado en comparación con las tuberías tradicionales basadas en WebGL y la CPU.12 Esto permite que un artista capture un espacio físico real y lo transforme en una instalación digital interactiva accesible a través de una simple URL, sin necesidad de instalaciones pesadas.24

## **Interactividad y fluidez: GSAP y la micro-animación de alto nivel**

Si Three.js es el músculo y WebGPU el sistema nervioso, GSAP (GreenSock Animation Platform) es el corazón que bombea vida a la interacción del usuario.28 Para una aplicación artística, la fluidez es innegociable; cualquier salto en los fotogramas (dropped frames) rompe la ilusión de la obra de arte.30

GSAP destaca como la librería más robusta para manejar miles de animaciones simultáneas sin pérdida de rendimiento.28 A diferencia de los sistemas de animación integrados en frameworks de UI, GSAP manipula directamente las propiedades de los objetos, evitando los ciclos de renderizado costosos de la CPU.28

### **Comparativa de librerías de movimiento para la vanguardia**

| Dimensión | GSAP (El Estándar Profesional) | Framer Motion (El Aliado de React) | Rive (Animación Vectorial Interactiva) |
| :---- | :---- | :---- | :---- |
| **Uso Principal** | Orquestación compleja, líneas de tiempo, scroll-trigger 29 | Transiciones de UI, gestos, animaciones de layout 28 | Animaciones vectoriales reactivas con estados lógicos 32 |
| **Rendimiento** | Máximo, optimizado para carga pesada 30 | Bueno para UI, puede sufrir en escenas masivas 28 | Excelente, basado en un motor de renderizado propio 32 |
| **Interactividad** | Programática y profunda 33 | Declarativa y basada en componentes 33 | Nativa a través de máquinas de estado visuales 32 |
| **SVG y Morphing** | MorphSVGPlugin (El mejor del mercado) 28 | Soporte básico para transformaciones 28 | Control total sobre vectores en tiempo real 32 |

En 2025, el uso de Rive se ha vuelto esencial para integrar personajes o interfaces vectoriales que reaccionan dinámicamente al puntero o a variables de estado del sitio.32 Mientras que Lottie reproduce una animación pre-diseñada, Rive permite que la animación "viva" y responda a la lógica de la aplicación artística.32

## **El sonido como materia prima: Tone.js y la sinestesia digital**

Una obra de arte digital que ignore el sonido está incompleta. Tone.js es el framework de referencia para crear música interactiva y síntesis sonora en el navegador, permitiendo una integración profunda entre lo visual y lo auditivo.34 Tone.js no solo permite reproducir audio, sino que ofrece abstracciones para construir sintetizadores, secuenciadores y efectos de audio complejos que corren sobre la Web Audio API.34

### **Integración de audio reactivo en Three.js**

La verdadera vanguardia se encuentra en la reciprocidad: el sonido afecta a la imagen y la imagen afecta al sonido.37 Utilizando el AudioAnalyser de Three.js junto con la lógica de secuenciación de Tone.js, los artistas pueden crear visuales que pulsan con la música o sintetizadores que cambian su timbre según la posición de la cámara 3D.35 Esta sinestesia digital es lo que transforma una aplicación web en una experiencia multisensorial única.35

Tone.js permite manejar el tiempo musical a través de su "Transport", que ofrece una precisión de muestra para sincronizar ritmos con animaciones visuales.34 Esto es vital para proyectos de arte generativo donde la obra evoluciona con el tiempo o responde a la entrada de micrófono del usuario en tiempo real.39

## **Síntesis de la arquitectura para una obra de arte digital única**

Para construir la aplicación web más increíble y vanguardista, no se debe buscar una única librería, sino una orquestación de tecnologías que trabajen en concierto. La combinación ganadora para 2025-2026 se perfila de la siguiente manera:

1. **Motor de Renderizado:** Three.js con WebGPURenderer para una potencia de cómputo inigualable y soporte para TSL.4  
2. **Lógica Visual:** Uso intensivo de Shaders TSL para crear materiales procedimentales, efectos de distorsión y partículas dinámicas.6  
3. **Dirección y Animación:** Theatre.js para la orquestación cinemática de la escena, permitiendo una narrativa visual pulida.5  
4. **Interacción de Capas:** GSAP para la fluidez del scroll y micro-interacciones de alto rendimiento, junto con Rive para elementos vectoriales interactivos.28  
5. **Entorno Sonoro:** Tone.js para la síntesis de audio generativo y reactivo, creando una atmósfera inmersiva.34  
6. **Técnicas Especiales:** Integración de 3D Gaussian Splatting para capturas fotorrealistas de la realidad o Raymarching para geometrías matemáticas puras.12

Este enfoque no solo aprovecha las librerías más avanzadas, sino que adopta una filosofía de "artesanía digital" similar a la de estudios líderes como Lusion o Active Theory.41 Al unificar estos frameworks, el desarrollador trasciende la técnica para entrar en el terreno de la expresión pura, creando una obra de arte digital que es, en esencia, una experiencia viva y nunca antes vista en el navegador.43

#### **Fuentes citadas**

1. Best Web and Interactive Websites \- Awwwards, acceso: febrero 2, 2026, [https://www.awwwards.com/websites/web-interactive/](https://www.awwwards.com/websites/web-interactive/)  
2. 25 Stunning Interactive Website Examples & Design Trends (2025) \- The Web Factory, acceso: febrero 2, 2026, [https://www.thewebfactory.us/blogs/25-stunning-interactive-website-examples-design-trends/](https://www.thewebfactory.us/blogs/25-stunning-interactive-website-examples-design-trends/)  
3. WebGPU in 2025: The Complete Developer's Guide \- DEV Community, acceso: febrero 2, 2026, [https://dev.to/amaresh\_adak/webgpu-in-2025-the-complete-developers-guide-3foh](https://dev.to/amaresh_adak/webgpu-in-2025-the-complete-developers-guide-3foh)  
4. What's New in Three.js (2026): WebGPU, New Workflows & Beyond \- Utsubo, acceso: febrero 2, 2026, [https://www.utsubo.com/blog/threejs-2026-what-changed](https://www.utsubo.com/blog/threejs-2026-what-changed)  
5. With THREE.js \- Theatre.js, acceso: febrero 2, 2026, [https://www.theatrejs.com/docs/0.5/getting-started/with-three-js](https://www.theatrejs.com/docs/0.5/getting-started/with-three-js)  
6. Three.js Shading Language \- GitHub, acceso: febrero 2, 2026, [https://github.com/mrdoob/three.js/wiki/Three.js-Shading-Language](https://github.com/mrdoob/three.js/wiki/Three.js-Shading-Language)  
7. TSL: A Better Way to Write Shaders in Three.js, acceso: febrero 2, 2026, [https://threejsroadmap.com/blog/tsl-a-better-way-to-write-shaders-in-threejs](https://threejsroadmap.com/blog/tsl-a-better-way-to-write-shaders-in-threejs)  
8. Three.js vs. Babylon.js: Which is better for 3D web development? \- LogRocket Blog, acceso: febrero 2, 2026, [https://blog.logrocket.com/three-js-vs-babylon-js/](https://blog.logrocket.com/three-js-vs-babylon-js/)  
9. WebGL vs. WebGPU Explained \- Three.js Roadmap, acceso: febrero 2, 2026, [https://threejsroadmap.com/blog/webgl-vs-webgpu-explained](https://threejsroadmap.com/blog/webgl-vs-webgpu-explained)  
10. WebGPU finally on Web \- Evergine, acceso: febrero 2, 2026, [https://evergine.com/webgpu-finally-on-web/](https://evergine.com/webgpu-finally-on-web/)  
11. Three.js vs Babylon.js vs PlayCanvas | Comparison Guide 2026, acceso: febrero 2, 2026, [https://www.utsubo.com/blog/threejs-vs-babylonjs-vs-playcanvas-comparison](https://www.utsubo.com/blog/threejs-vs-babylonjs-vs-playcanvas-comparison)  
12. WebGPU Gaussian Splatting for Real-Time 3D Scenes \- Emergent Mind, acceso: febrero 2, 2026, [https://www.emergentmind.com/topics/webgpu-powered-gaussian-splatting](https://www.emergentmind.com/topics/webgpu-powered-gaussian-splatting)  
13. Babylon.js Vs. Three.js-comparison \- Ansi ByteCode LLP, acceso: febrero 2, 2026, [https://ansibytecode.com/babylon-js-vs-three-js-comparison/](https://ansibytecode.com/babylon-js-vs-three-js-comparison/)  
14. A collection of WebGL and WebGPU frameworks and libraries \- GitHub Gist, acceso: febrero 2, 2026, [https://gist.github.com/dmnsgn/76878ba6903cf15789b712464875cfdc](https://gist.github.com/dmnsgn/76878ba6903cf15789b712464875cfdc)  
15. Babylon.js vs Three.js: Which Should You Choose? | by Devin Rosario, acceso: febrero 2, 2026, [https://javascript.plainenglish.io/babylon-js-vs-three-js-which-should-you-choose-14faef9f7d78](https://javascript.plainenglish.io/babylon-js-vs-three-js-which-should-you-choose-14faef9f7d78)  
16. Babylon.js vs Three.js: Choosing the Right 3D Framework for Long-Term Team Scalability, acceso: febrero 2, 2026, [https://dev.to/devin-rosario/babylonjs-vs-threejs-choosing-the-right-3d-framework-for-long-term-team-scalability-col](https://dev.to/devin-rosario/babylonjs-vs-threejs-choosing-the-right-3d-framework-for-long-term-team-scalability-col)  
17. Field Guide to TSL and WebGPU \- The Blog of Maxime Heckel, acceso: febrero 2, 2026, [https://blog.maximeheckel.com/posts/field-guide-to-tsl-and-webgpu/](https://blog.maximeheckel.com/posts/field-guide-to-tsl-and-webgpu/)  
18. Interactive Text Destruction with Three.js, WebGPU, and TSL ..., acceso: febrero 2, 2026, [https://tympanus.net/codrops/2025/07/22/interactive-text-destruction-with-three-js-webgpu-and-tsl/](https://tympanus.net/codrops/2025/07/22/interactive-text-destruction-with-three-js-webgpu-and-tsl/)  
19. Why I Love WebGPU With Three.js \- YouTube, acceso: febrero 2, 2026, [https://www.youtube.com/watch?v=T6A-K9uLdIU](https://www.youtube.com/watch?v=T6A-K9uLdIU)  
20. Theatre.js \- Wawa Sensei, acceso: febrero 2, 2026, [https://wawasensei.dev/courses/react-three-fiber/lessons/theatre-js](https://wawasensei.dev/courses/react-three-fiber/lessons/theatre-js)  
21. Mastering Theatre.js Animations: Learn to Create Dynamic Visuals \- Codrops, acceso: febrero 2, 2026, [https://tympanus.net/codrops/2023/03/30/mastering-theatre-js-animations-learn-to-create-dynamic-visuals/](https://tympanus.net/codrops/2023/03/30/mastering-theatre-js-animations-learn-to-create-dynamic-visuals/)  
22. Aurel's Grand Theater \- Showcase \- three.js forum, acceso: febrero 2, 2026, [https://discourse.threejs.org/t/aurels-grand-theater/81452](https://discourse.threejs.org/t/aurels-grand-theater/81452)  
23. The Best of WebGPU in February 2025, acceso: febrero 2, 2026, [https://www.webgpuexperts.com/best-webgpu-updates-february-2025](https://www.webgpuexperts.com/best-webgpu-updates-february-2025)  
24. 3D Gaussian Splatting: Complete Guide to Services, Use Cases & Web Viewers (2026), acceso: febrero 2, 2026, [https://www.utsubo.com/blog/gaussian-splatting-guide](https://www.utsubo.com/blog/gaussian-splatting-guide)  
25. Lusion | Communication Arts, acceso: febrero 2, 2026, [https://www.commarts.com/webpicks/lusion](https://www.commarts.com/webpicks/lusion)  
26. From Concept Prototyping to Production in a Creative Studio | by Lusion Ltd \- Medium, acceso: febrero 2, 2026, [https://medium.com/lusion-ltd/from-concept-prototyping-to-production-in-a-creative-studio-f2083e96c4b9](https://medium.com/lusion-ltd/from-concept-prototyping-to-production-in-a-creative-studio-f2083e96c4b9)  
27. Web3D '25: Proceedings of the 30th International Conference on 3D Web Technology \- acm siggraph, acceso: febrero 2, 2026, [https://www.siggraph.org/wp-content/uploads/2025/08/Web3D.html](https://www.siggraph.org/wp-content/uploads/2025/08/Web3D.html)  
28. Framer vs GSAP: Which Animation Library Should You Choose?, acceso: febrero 2, 2026, [https://pentaclay.com/blog/framer-vs-gsap-which-animation-library-should-you-choose](https://pentaclay.com/blog/framer-vs-gsap-which-animation-library-should-you-choose)  
29. GSAP vs. Framer Motion: A Comprehensive Comparison | by Sachin Tharaka | Medium, acceso: febrero 2, 2026, [https://tharakasachin98.medium.com/gsap-vs-framer-motion-a-comprehensive-comparison-0e4888113825](https://tharakasachin98.medium.com/gsap-vs-framer-motion-a-comprehensive-comparison-0e4888113825)  
30. Web Animation for Your React App: Framer Motion vs GSAP \- Semaphore CI, acceso: febrero 2, 2026, [https://semaphore.io/blog/react-framer-motion-gsap](https://semaphore.io/blog/react-framer-motion-gsap)  
31. Explore the Top 10 Web Design Trends of 2025, acceso: febrero 2, 2026, [https://www.codendesign.com.au/blog/explore-the-top-10-web-design-trends-of-2025/](https://www.codendesign.com.au/blog/explore-the-top-10-web-design-trends-of-2025/)  
32. Rive vs Lottie: Which Animation Tool Should You Use in 2025? \- DEV Community, acceso: febrero 2, 2026, [https://dev.to/uianimation/rive-vs-lottie-which-animation-tool-should-you-use-in-2025-p4m](https://dev.to/uianimation/rive-vs-lottie-which-animation-tool-should-you-use-in-2025-p4m)  
33. Framer Motion vs GSAP \- Gabriel Veres, acceso: febrero 2, 2026, [https://gabrielveres.com/blog/framer-motion-vs-gsap](https://gabrielveres.com/blog/framer-motion-vs-gsap)  
34. Tone.js, acceso: febrero 2, 2026, [https://tonejs.github.io/](https://tonejs.github.io/)  
35. Tone.js and The web audio API \- Medium, acceso: febrero 2, 2026, [https://medium.com/@luismiguelascencio/tone-js-and-the-web-audio-api-8bb513655e59](https://medium.com/@luismiguelascencio/tone-js-and-the-web-audio-api-8bb513655e59)  
36. Tone.js and the Web Audio API \- DEV Community, acceso: febrero 2, 2026, [https://dev.to/snelson723/tonejs-and-the-web-audio-api-36cj](https://dev.to/snelson723/tonejs-and-the-web-audio-api-36cj)  
37. \[Demo\] Audio reactive party visuals with three.js : r/threejs \- Reddit, acceso: febrero 2, 2026, [https://www.reddit.com/r/threejs/comments/5vkxm8/demo\_audio\_reactive\_party\_visuals\_with\_threejs/](https://www.reddit.com/r/threejs/comments/5vkxm8/demo_audio_reactive_party_visuals_with_threejs/)  
38. How to create a grid of points reactive to audio \- Questions \- three.js forum, acceso: febrero 2, 2026, [https://discourse.threejs.org/t/how-to-create-a-grid-of-points-reactive-to-audio/60273](https://discourse.threejs.org/t/how-to-create-a-grid-of-points-reactive-to-audio/60273)  
39. Tone.js Examples, acceso: febrero 2, 2026, [https://tonejs.github.io/examples/](https://tonejs.github.io/examples/)  
40. Painting with Math: A Gentle Study of Raymarching \- The Blog of Maxime Heckel, acceso: febrero 2, 2026, [https://blog.maximeheckel.com/posts/painting-with-math-a-gentle-study-of-raymarching/](https://blog.maximeheckel.com/posts/painting-with-math-a-gentle-study-of-raymarching/)  
41. Sites Of The Year \- Awwwards, acceso: febrero 2, 2026, [https://www.awwwards.com/websites/sites\_of\_the\_year/](https://www.awwwards.com/websites/sites_of_the_year/)  
42. About Lusion, acceso: febrero 2, 2026, [https://v2.lusion.co/about/](https://v2.lusion.co/about/)  
43. Lusion \- Realise Your Creative Ideas, acceso: febrero 2, 2026, [https://lusion.co/](https://lusion.co/)  
44. Site of the Year 2023 on Awwwards, acceso: febrero 2, 2026, [https://www.awwwards.com/annual-awards-2023/site-of-the-year](https://www.awwwards.com/annual-awards-2023/site-of-the-year)