#! /usr/bin/env python
# coding=utf-8
import friction_tools as ft

# init variables
filename = 'simulation'
global_interval = 10 # femtoseconds
sim = ft.FrictionSimulation()

# create the lattices used
sim.create_slab(element='Au',xy_cells=5,z_cells=2,bottom_z=2.0)
sim.create_slab(element='Zn',xy_cells=5,z_cells=2,bottom_z=-1.0)

sim.list_atoms() # print atoms to terminal for debug purposes

# needed interactions
sim.create_interaction(['Au','Au'], strength=1.0, equilibrium_distance=2.39)
sim.create_interaction(['Zn','Zn'], strength=0.7, equilibrium_distance=1.39)
sim.create_interaction(['Au','Zn'], strength=0.2, equilibrium_distance=4.39)

au_indices = sim.get_indices_by_element('Au')
Zn_indices = sim.get_indices_by_element('Zn')


sim.set_velocities(indices=au_indices, velocity=[0, 0.5, 0])

# default settings
sim.create_dynamics(dt=1.0)


sim.save_trajectory_during_simulation(interval=global_interval, filename='{}.traj'.format(filename)) # 5 fs
sim.gather_energy_and_temperature_during_simulation(interval=global_interval, filename='energy.txt')
sim.gather_average_position_during_simulation(interval=global_interval,indices=au_indices,filename='au_position.txt')
sim.gather_average_position_during_simulation(interval=global_interval,indices=Zn_indices,filename='Zn_position.txt')

# - monitor the simulation by printing info to stdout
sim.print_stats_during_simulation(interval=50)

import time
t0 = time.time()
# run the simulation for 1000 fs
sim.run_simulation(time=2000.0)
t1 = time.time()

print "time taken {ti} s".format(ti=str(int(t1-t0)))

# generated .traj to VMD-supported .xyz
ft.trajectory_to_xyz(filename_in='{}.traj'.format(filename), filename_out='{}.xyz'.format(filename))
