function [I_R1, I_R2, I_R3, I_R4, I_R5, I_E1, I_E3, I_J1, I_C1, I_L1, B_P] = circuit_alternativ (R1, R2, R3, R4, R5, E1, E2, E3, J1, L1, C1)
  
% circuit_alternativ (1, 1, -2, 1, 1.33, 5, 1, 4, 2, 0.1/pi, 0.0001/pi)
  f = 50;
  w = 2 * pi * f;
  R_L1 = i * w * L1;
  R_C1 = 1 / (i * w * C1);
  J = J1 * (1 + i) * sqrt(2) / 2;
  
  % rezistentele in paralel si in serie
  R_P = R2 * R_C1 / (R2 + R_C1);
  R_S = R1 + R_L1;
  
  % potentialele nodurilor
  N3 = i * E3;

  %retete
  G11 = (1 / R_S) + (1 / R_P);
  G22 = (1 / R_S) + (1 / R4) + (1 / R3);
  G23 = - (1 / R4);
  G13 = - (1 / R_P);
  I_SC1 = J - (E1 / R_P);
  I_SC2 = - J + (E2 * i / R3);
  
  % ecuatia pentru N2
  N2 = (G11 * I_SC2) / (G11 * G22);
  N1 = (I_SC1 - (G13 * N3)) / G11;
  
  % calculul intensitatilor
  I_R1 = (N1 - N2) / R_S;
  I_R2 = (N1 - N3 - E1) / R2;
  I_R3 = (- N2 - E2 * i) / R3;
  I_R4 = (N2 - N3) / R4;
  I_R5 = - N3 / R5;
  I_L1 = I_R1;
  I_C1 = (N1 - N3 - E1) / R_C1;
  I_E1 = (N1 - N3 - E1) / R_P;
  I_E3 = I_R3 + I_R5 - I_R4;
  I_J1 = J;
  
  % bilantul puterilor
  P_C = R1 * I_R1 ^ 2 + R_L1 * I_L1 ^ 2 + R2 * I_R2 ^ 2 + R_C1 * I_C1 ^ 2 + R4 * I_R4 ^ 2 + R3 * I_R3 ^ 2 + R5 * I_R5 ^ 2;
  P_G = E1 * (I_E1)' - E2 * i * (I_R2)' + E3 * i * (I_E3)' + (N1 - N2) * (I_J1)';
  B_P = abs(P_C - P_G);
  
  %reprezentare in timp a curentului prin R4
  r = abs (I_R4);
  phi = angle (I_R4);
  t = [0:0.0001:0.1];
  y = r * sqrt(2) * sin(w * t + phi);
  plot (t, y);
  title ("Curentul prin R4");
  ylabel ("i_R4(t)", "FontSize", 16);
endfunction

