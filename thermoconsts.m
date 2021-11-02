% Script to run in order to initiate a bunch of constants useful for thermal

J_eV = 1.6021773e-19; % Joules per eV
eV_J = 1./J_eV; % eV per Joule

% Functions for converting between eV and J:
J_to_eV = @(in_J) in_J .* eV_J;
eV_to_J = @(in_eV) in_eV .* J_eV;

T20C = 293.15; % 20C "Room Temperature" in Kelvin
T0C = 273.15; % 0C in Kelvin

hPlanck = 6.6260755e-34; % Planck's Constant in J*s (= J/Hz)
hBar = hPlanck ./ (2.*pi); % Planck's Constant in J*s/radian (= J/(radians/sec))

kB = 1.380658e-23; % Boltzmann's constant in J/K

ePlus = 1.60217733e-19; % Proton charge in Coulombs

a0 = 5.29177e-12; % Bohr radius in m

muB = 9.2740154e-24; % Bohr magneton in J/T

nAvo = 6.0221367e23; % Avogadro's number in particles/mol

cLight = 2.99792458e8; % the fastest speed in m/s

m_e = 9.1093897e-31; % electron rest mass in kg
m_pro = 1.6726231e-27; % proton rest mass in kg
m_neu = 1.6749286e-27; % neutron rest mass in kg
m_atom = 1.66054e-27; % atomic mass unit (1/12 mass of carbon 12 atom) in kg

mu0 = pi*4e-7; % magnetic permeability of free space in H/m
eps0 = 8.854187817e-12; % electric permittivity of free space in F/m