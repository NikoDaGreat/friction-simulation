#! /usr/bin/env python
# coding=utf-8
import friction_tools as ft
import numpy as np
import time
import os
#tiedostojen lukemiseen


# init variables
filename = 'simulation'
global_interval = 5 # femtoseconds
sim = ft.FrictionSimulation()

def xy_cells(lattice_constant):
    return int(np.round(10.0/lattice_constant))

def equi_dist(xy):
    return np.divide(np.sqrt(50), xy).item()

xy_cells_Al = xy_cells(4.046)
equi_dist_Al = equi_dist(xy_cells(4.046))


#simuloidut voimat(testi)
#forces = np.linspace(0,0.1,11)

forces = [0.01]

for N in forces:
    #keskimääräinen y-suuntainen voima
    MeanYs = np.zeros(np.size(forces))

    #keskimääräinen z-suuntainen voima
    MeanZs = np.zeros(np.size(forces))

    # create the lattices used
    sim.create_slab(element='Al',xy_cells=xy_cells(4.046),z_cells=3,bottom_z=12.0)
    sim.create_slab(element='Hg',xy_cells=1, z_cells=1, top_z=7.0)
    #sim.create_random_atoms(50, 'Hg', 2.0, 10, minimum_distance=-0.4+equi_dist(xy_cells(3)))
    sim.create_slab(element='Al',xy_cells=xy_cells(4.046),z_cells=3,top_z=0.0)


    sim.list_atoms() # print atoms to terminal for debug purposes

    #the potential energy well (in eV) and the atomic separation (in Å)
    sim.create_interaction(['Al','Al'], strength=1.0, equilibrium_distance=equi_dist_Al)
    sim.create_interaction(['Hg','Hg'], strength=0.30, equilibrium_distance=equi_dist(1) )
    sim.create_interaction(['Al','Hg'], strength=0.6, equilibrium_distance=2+1)

    Al_top_indices = sim.get_indices_z_more_than(12.0)
    Al_toppest_indices = sim.get_indices_z_more_than(12.0+6)
    Al_bot_indices= sim.get_indices_z_less_than(-3.5)
    Hg_indices = sim.get_indices_by_element('Hg')

    sim.fix_velocities(indices=Al_top_indices, velocity=[0, 0.005, 0], xyz=[True,True,False])

    # pohjaslabin pohja pysyy paikallaan
    sim.fix_positions(Al_bot_indices)

    # yläslabille painovoima
    sim.add_constant_force(sim.get_indices_z_more_than(15.0),[0,0,-0.05])

    # default settings
    sim.set_temperature(temperature=273) # huoneenlämpö
    sim.create_dynamics(dt=global_interval, temperature=273, coupled_indices=Al_bot_indices)


    sim.save_trajectory_during_simulation(interval=global_interval, filename='{}/data/{}_{}.traj'.format(os.getcwd(), filename, N)) # 5 fs
    sim.gather_energy_and_temperature_during_simulation(interval=global_interval, filename='{}/data/energy_{}.txt'.format(os.getcwd(),filename, N))
    #sim.gather_average_position_during_simulation(interval=global_interval,indices=Al_top_indices,filename='Al_position.txt')
    #sim.gather_average_position_during_simulation(interval=global_interval,indices=Hg_indices,filename='Hg_position.txt')
    sim.gather_average_force_during_simulation(interval=global_interval,indices=Al_toppest_indices,filename='{}/data/Al_forces_{}.txt'.format(os.getcwd(),N))

    # - monitor the simulation by printing info to stdout
    sim.print_stats_during_simulation(interval=50)

    t0 = time.time()
    # run the simulation for 1000 fs
    sim.run_simulation(time=10000.0)
    t1 = time.time()

    print "time taken {ti} s".format(ti=str(int(t1-t0)))
    #avataan tekstitiedosto
    file=np.loadtxt('{}/data/Al_forces_{}.txt'.format(os.getcwd,N))
    #tallennetaan voimat vektoreihin
    #MeanYs[length(MeanYs)] = np.mean(file[int(np.round(length(MeanYs)/2)):,1])
    #MeanZs[length(MeanZs)] = np.mean(file[int(np.round(length(MeanZs)/2)):,2])

    #coeff = [np.mean(file[(np.size(file)/2):][:,1]), np.mean(file[(np.size(file)/2):][:,2]) ]
    #np.save("coefficient_{}".format(N), coeff )
    ft.trajectory_to_xyz(filename_in='{}_{}.traj'.format(filename, N), filename_out='{}_{}.xyz'.format(filename, N))



    # generated .traj to VMD-supported .xyz
