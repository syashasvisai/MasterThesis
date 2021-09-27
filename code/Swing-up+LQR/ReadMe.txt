• model_ADIP.m - Generates the required governing equations of motion, Mass matrix, Linear matrices for LQR, Matrices for LPV model and equation for swing up input. 
Update the linear_matrices.m file if any changes are made to the existing model.

• main_ADIP.m - Matlab code to test the derived model. Change equations in the nl_dynamics.m function if there is any change in the derived equations from above. 

• ADIP_Sim.slx - Simulink file for ADIP. Run the main_ADIP.m before running this.


• ADIP_greyID.m - Non-linear grey box parameter estimator.

• ADIP_est.m - Non-linear equations for the ADIP_greyID.m file.

• parameters.m - To change the values of parameters.



Date: 12/11/20
NOTE: The friction parameters were approximated using data recorded with a faulty encoder, hence they may not be correct. The parameters need to be re-estimated and the swing-up might have to be retuned with the new parameters.