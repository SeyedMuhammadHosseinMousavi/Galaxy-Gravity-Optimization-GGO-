# 🌌 Galaxy Gravity Optimization (GGO) Algorithm
### Galaxy Gravity Optimization(GGO) An Algorithm for Optimization, Inspired by Comets Life Cycle
- Link to the paper:
- https://ieeexplore.ieee.org/abstract/document/8515125
---

## 📚 Description

Galaxy Gravity Optimization is a nature-inspired evolutionary algorithm that mimics the behavior of comets in the solar system. Each comet represents a solution and evolves through gravitational interactions, mass addition, and mass loss to find the optimal solution to a given problem.
![ggo1](https://github.com/user-attachments/assets/d04899cc-8dea-487d-a32e-c95252b5bc4f)

---

## 🚀 Steps in the Algorithm

1. **Initialization**
   - Generate an initial population of comets and smaller celestial bodies.
   - Define comet properties: mass, orbit length, and fitness.

2. **Fitness Evaluation**
   - Evaluate each comet using the benchmark fitness function.

3. **Parent Selection**
   - Use roulette wheel selection to choose comets for the next generation based on fitness.

4. **Gravitational Operators**
   - **Mass Add Mutation**: Increase a comet's mass and improve its orbit based on gravitational effects.
   - **Mass Loss Mutation**: Reduce a comet's mass near the solar perigee due to proximity to the sun.

5. **Orbit Mutation**
   - Modify the orbit of comets when influenced by the gravitational pull of larger celestial bodies.

6. **Fitness Calculation**
   - Calculate the total fitness of the comet population based on the length and properties of their orbits.

7. **Replacement and Iteration**
   - Replace weaker comets with better-performing ones and repeat the process for a fixed number of iterations.

8. **Convergence**
   - Track and plot the best fitness values over iterations.
![ggo2](https://github.com/user-attachments/assets/5c4f6347-c321-45dd-9772-dfeffa3c1f9b)

---
- DOI: 10.1109/AISP.2017.8515125
- ------------------------------------------------ 


![Galaxy Gravity Optimization Algorithm (GGO)](https://user-images.githubusercontent.com/11339420/148934438-b8b5ebfc-0860-49d6-9168-e84a8efaa75d.JPG)

### Please cite:
- Mousavi, Seyed Muhammad Hossein, S. Younes MiriNezhad, and Mir Hossein Dezfoulian. "Galaxy gravity optimization (GGO) an algorithm for optimization, inspired by comets life cycle." 2017 Artificial Intelligence and Signal Processing Conference (AISP). IEEE, 2017.
