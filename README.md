# Breaking-AES-through-DPA
Given a set of power traces taken during AES-ECB executions with the associated input/output values of AES, the 128-bit secret key is extracted via Differential Power Analysis (DPA)

Given -
Power Trace file with 400 measurements for 10,000 inputs.
Input file with 10,000 128-bit inputs.

File descriptions -
keyguesses.m : Performs DPA on first byte of the input
best2keys.m : Plots the best two key guesses for DPA on first byte
keyevolution.m : Plots the evolution of key hypothesis for 10,000 measurements at maximum leak point
