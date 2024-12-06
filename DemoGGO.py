import numpy as np
import matplotlib.pyplot as plt

# Define the Ackley function
def ackley_function(x):
    a, b, c = 20, 0.2, 2 * np.pi
    d = len(x)
    sum1 = np.sum(x ** 2)
    sum2 = np.sum(np.cos(c * x))
    return -a * np.exp(-b * np.sqrt(sum1 / d)) - np.exp(sum2 / d) + a + np.exp(1)

# Initialize the population
def initialize_population(pop_size, dim, bounds):
    return np.random.uniform(bounds[0], bounds[1], (pop_size, dim))

# Evaluate fitness of the population
def evaluate_population(population):
    return np.array([ackley_function(ind) for ind in population])

# Parent selection using roulette wheel
def roulette_wheel_selection(population, fitness, num_parents):
    fitness = np.max(fitness) - fitness  # Convert to maximization problem
    probabilities = fitness / np.sum(fitness)
    selected_indices = np.random.choice(np.arange(len(population)), size=num_parents, p=probabilities)
    return population[selected_indices]

# Mass add mutation
def mass_add_mutation(population, bounds, mutation_rate=0.1):
    for ind in population:
        if np.random.rand() < mutation_rate:
            ind += np.random.uniform(-0.1, 0.1, size=ind.shape)
            ind = np.clip(ind, bounds[0], bounds[1])
    return population

# Mass loss mutation
def mass_loss_mutation(population, fitness, loss_rate=0.1):
    for i, ind in enumerate(population):
        if np.random.rand() < loss_rate:
            population[i] -= fitness[i] * 0.1
    return population

# Main GGO algorithm
def galaxy_gravity_optimization(bounds, dim, pop_size=200, max_iter=200):
    population = initialize_population(pop_size, dim, bounds)
    fitness = evaluate_population(population)
    best_solutions = []
    best_costs = []

    for iteration in range(max_iter):
        # Select parents
        parents = roulette_wheel_selection(population, fitness, pop_size // 2)
        
        # Apply mutations
        population = mass_add_mutation(parents, bounds)
        population = mass_loss_mutation(population, fitness)

        # Evaluate new population
        fitness = evaluate_population(population)
        
        # Store the best solution
        best_idx = np.argmin(fitness)
        best_solutions.append(population[best_idx].copy())
        best_costs.append(fitness[best_idx])
        
        # Print iteration progress
        print(f"Iteration {iteration + 1}: Best Cost = {fitness[best_idx]}")

    # Plot results
    plt.figure(figsize=(10, 6))
    plt.plot(best_costs, label="Best Fitness")
    plt.title("Convergence Curve of GGO on Ackley Function")
    plt.xlabel("Iterations")
    plt.ylabel("Best Fitness")
    plt.legend()
    plt.grid()
    plt.show()

    return best_solutions, best_costs

# Run GGO on Ackley function
bounds = [-5, 5]  # Bounds for Ackley function
dim = 2           # Dimensionality of the problem
galaxy_gravity_optimization(bounds, dim)
