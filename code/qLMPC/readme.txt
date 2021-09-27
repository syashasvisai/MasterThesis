SLX-files in the current folder ADIPSim 
- simADIP_2018b
  run_qLMPC -  parameters for initialization, other files for simulation   

MATLAB Code files in the current folder ADIPSim needed for simulation
---
From Pablo S.G. Cisneros, Herbert Werner, ICS TUHH
- ABqL
  calculates system (A) and input (B) matrix for quasiLPV
  representation               
- run_qLMPC
  Initialize physical constants and parameters and design parameters              
- HSqLd            
  calculate matrices L, S, H and g for Lemke's algorithm

From git publicly available
- lemke
 Solves linear complementarity problems (LCPs)

For Reporting from Antje Dittmer
---
- createReport
  Display simulation model and results used as basis for the paper 
  Pablo S.G. Cisneros, Herbert Werner, 'Wide Range Stabilization of a 
  Pendubot using quasi-LPV Predictive Control', 2019
- colorInOutports
  colorInOutports colors in and outports of a model   


