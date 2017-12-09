function H = ECP_SDF(class1,u)
H = class1 * ((transpose(class1) * class1) \ u);