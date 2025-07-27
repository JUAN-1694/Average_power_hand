# Average Power-Based Grip Force Control for Robotic Hand Prostheses

This repository contains the source code and supporting files for the article:

"Average Power as an Alternative Variable for Power Grip Control in Robotic Hands Without Using Force Measurements"
Manuscript ID: IEEE LATAM Submission ID: 9871
Authors: Juan F Solarte, Carlos A Gaviria     

# Description

This work presents a sensorless grip force control method for robotic prosthetic hands. It uses average electrical power as a control variable, avoiding the need for force sensors. The system was experimentally validated using a five-finger underactuated robotic hand and a variable-stiffness instrumented object.

# Included Scripts
This repository contains all scripts required to reproduce the simulation and numerical results presented in the article.
| Script             | Related Figure(s)                                             | Description                                                                                                                                                                                                                                                                               |
|-------------------|---------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Prueba_potencia.m` | Fig. 7, Fig. 9                                                | Generates time-domain plots of grip force, average power, and actuator current during square wave tracking. Also fits linear regression models to estimate grip force using actuator current and average power.                                                                          |
| `graficas.m`        | Fig. 8a–b, Fig. 10a–d, Fig. 11a–d, Fig. 12a–d, Fig. 13a–d      | Fig. 8: Computes and compares cross-correlation between grip force and both current and average power signals. Fig. 10: Simulates square waveform reference tracking and plots grip force response. Fig. 11: Shows actuator positions during square wave tracking. Fig. 12: Simulates cosine reference tracking. Fig. 13: Shows actuator positions during cosine wave tracking. |




# Contact
For questions or collaborations:
Juan F Solarte P – jfsolarte@unicauca.edu.co
Carlos A Gaviria - cgaviria@unicauca.edu.co
Affiliation: Universidad del Cauca

2025. Released under the MIT License.

