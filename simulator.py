#! /usr/bin/env python
# coding=utf-8
import friction_tools as ft
import numpy as np
import time

# init variables
filename = 'simulation'
global_interval = 10 # femtoseconds
sim = ft.FrictionSimulation()

def xy_cells(lattice_constant):
    return int(np.round(10.0/lattice_constant))

def equi_dist(xy):
    return np.divide(np.sqrt(50), xy).item()

xy_cells_Al = xy_cells(4.046)
equi_dist_Al = equi_dist(xy_cells(4.046))
# create the lattices used
sim.create_slab(element='Al',xy_cells=xy_cells(4.046),z_cells=2,bottom_z=3.0)
# sim.create_slab(element='Hg',xy_cells=1,z_cells=1,top_z=1.0)
sim.create_random_atoms(50, 'Hg', 0.5, 2.5, minimum_distance=1.2)
sim.create_slab(element='Al',xy_cells=xy_cells(4.046),z_cells=2,top_z=0.0)


sim.list_atoms() # print atoms to terminal for debug purposes

#the potential energy well (in eV) and the atomic separation (in Å)
sim.create_interaction(['Al','Al'], strength=1.0, equilibrium_distance=equi_dist_Al)
sim.create_interaction(['Hg','Hg'], strength=0.7, equilibrium_distance=1.39)
sim.create_interaction(['Al','Hg'], strength=0.2, equilibrium_distance=4.39)

Al_top_indices = sim.get_indices_z_more_than(2.9)
Al_bot_indices= sim.get_indices_z_less_than(-2.5)
Hg_indices = sim.get_indices_by_element('Hg')

sim.fix_velocities(indices=Al_top_indices, velocity=[0, 0.05, 0])


sim.fix_positions(Al_bot_indices)


# default settings
sim.create_dynamics(dt=1.0, temperature=300)


sim.save_trajectory_during_simulation(interval=global_interval, filename='{}.traj'.format(filename)) # 5 fs
sim.gather_energy_and_temperature_during_simulation(interval=global_interval, filename='energy.txt')
sim.gather_average_position_during_simulation(interval=global_interval,indices=Al_top_indices,filename='Al_position.txt')
sim.gather_average_position_during_simulation(interval=global_interval,indices=Hg_indices,filename='Hg_position.txt')

# - monitor the simulation by printing info to stdout
sim.print_stats_during_simulation(interval=50)

t0 = time.time()
# run the simulation for 1000 fs
sim.run_simulation(time=1000.0)
t1 = time.time()

print "time taken {ti} s".format(ti=str(int(t1-t0)))

# generated .traj to VMD-supported .xyz
ft.trajectory_to_xyz(filename_in='{}.traj'.format(filename), filename_out='{}.xyz'.format(filename))
