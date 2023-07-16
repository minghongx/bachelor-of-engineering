MODULE MainModule
	TASK PERS wobjdata injection_moulded_component:=[FALSE,TRUE,"",[[938.531,-169.195,224.994],[0.999711,-0.00375236,-0.0227022,-0.00692191]],[[0,0,0],[1,0,0,0]]];
	TASK PERS tooldata pen:=[TRUE,[[89.0841,1.02906,182.544],[0.688809,-0.000940055,0.724942,0.00098936]],[2,[0,50,88],[1,0,0,0],0,0,0]];
	CONST robtarget p10:=[[-312.23,-47.51,-51.50],[0.0710383,-0.193736,-0.955349,-0.211491],[-1,0,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p20:=[[-216.70,-56.35,-50.55],[0.0710342,-0.193742,-0.955349,-0.211487],[-1,0,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p30:=[[-157.21,-66.80,-51.63],[0.0710394,-0.193735,-0.955352,-0.211478],[-1,0,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p40:=[[-101.72,-55.82,-51.69],[0.0710467,-0.193741,-0.955351,-0.211476],[-1,0,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p50:=[[-6.21,-44.95,-49.34],[0.0710538,-0.193739,-0.955352,-0.211471],[-1,0,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p60:=[[19.96,-28.22,-52.14],[0.10907,-0.142095,-0.977374,-0.112483],[-1,0,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p70:=[[29.62,-5.99,-51.20],[0.14147,-0.101603,-0.977476,-0.11918],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p80:=[[42.34,143.43,-52.57],[0.152314,-0.0182053,-0.987717,-0.0297213],[-1,0,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p90:=[[28.54,278.66,-52.54],[0.135607,0.0959185,-0.981358,0.0966837],[0,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p110:=[[-6.85,319.58,-52.12],[0.118172,0.155679,-0.952576,0.233235],[0,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p100:=[[18.30,303.26,-52.12],[0.135063,0.0922034,-0.982169,0.0927404],[0,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p120:=[[-102.27,330.63,-52.68],[0.118167,0.155668,-0.952576,0.233243],[0,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p140:=[[-217.41,330.10,-52.44],[0.118646,0.155905,-0.952476,0.23325],[0,0,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p130:=[[-158.97,341.21,-50.75],[0.118656,0.155894,-0.952479,0.233242],[0,0,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p150:=[[-316.31,320.24,-54.13],[0.118666,0.155912,-0.952472,0.233255],[0,0,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p170:=[[-348.96,274.97,-53.26],[0.155151,-0.327674,0.904914,-0.22291],[-1,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p190:=[[-348.15,-12.67,-55.62],[0.120741,-0.111895,0.986348,-0.00437008],[-1,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p180:=[[-359.71,119.13,-59.09],[0.126201,-0.434851,0.847611,-0.276647],[-1,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p200:=[[-335.42,-35.85,-55.29],[0.0986495,-0.0420291,0.981591,0.158055],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p210:=[[-313.35,-48.34,-55.05],[0.0986496,-0.0420151,0.981593,0.158044],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p160:=[[-338.89,299.50,-53.24],[0.0393118,-0.294843,0.922054,-0.247667],[0,-1,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget home:=[[726.61,-16.60,422.39],[4.29334E-07,0.0160491,0.999871,-6.04518E-07],[-1,0,-5,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	TASK PERS wobjdata pen_holder:=[FALSE,TRUE,"",[[461.952,-481.479,139.004],[1.71079E-07,-7.71837E-06,-0.999754,0.0221597]],[[0,0,0],[1,0,0,0]]];
	CONST robtarget holder:=[[-80.95,87.24,-81.92],[0.999851,-0.00475216,0.000822151,0.0166019],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget above_holder:=[[-80.95,82.47,-189.28],[0.99985,-0.00477057,0.000824021,0.0166157],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p220:=[[-303.46,-48.89,141.46],[0.0710561,-0.193733,-0.955349,-0.211487],[-1,0,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget home10:=[[-80.95,82.47,-189.28],[0.99985,-0.00476668,0.000821735,0.0166131],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget above_holder10:=[[-80.95,82.47,-189.28],[0.99985,-0.00476668,0.000821735,0.0166131],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget holder10:=[[-80.95,82.47,-189.27],[0.99985,-0.00476497,0.000823528,0.0166143],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p230:=[[-323.70,-39.67,140.41],[0.132484,-0.0734318,0.98384,0.0954671],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget above_holder20:=[[-265.39,420.96,-300.63],[0.999546,-0.0142347,-0.00746106,0.0254869],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget above_holder30:=[[-265.39,420.96,-300.63],[0.999546,-0.0142347,-0.00746099,0.025486],[-1,-1,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget p240:=[[-312.23,-47.51,-51.50],[0.0710377,-0.193737,-0.955349,-0.211492],[-1,0,-4,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	VAR num time:=0;
	VAR clock clock2;
	VAR num total_time:=0;
	PROC main()
		MoveJ home, v600, fine, pen\WObj:=wobj0;
		TPReadFK reg1, "Dismiss the displayed time?", stEmpty, stEmpty, stEmpty, "Yes", "No";
		IF reg1 = 4 THEN
			TPErase;
		ENDIF
		ClkReset clock2;
		ClkStart clock2;
		! Set Do CONVEYOR HIGH
		TPWrite "Wait the conveyor for 3s";
		WaitTime 3;
		! Set Do CONVEYOR LOW
		TPWrite "The conveyor stops";
		MoveJ above_holder, v600, fine, pen\WObj:=pen_holder;
		MoveL holder, v600, fine, pen\WObj:=pen_holder;
		! closegripper
		WaitTime 2;
		! If the tool is not gripped, abort
		TPWrite "Gripped the tool";
		ClkReset clock1;
		ClkStart clock1;
		MoveL above_holder, v600, fine, pen\WObj:=pen_holder;
		TPWrite "Start applying the sealant";
		MoveL p10, v500, fine, pen\WObj:=injection_moulded_component;
		MoveL p20, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p30, p40, v500, fine, pen\WObj:=injection_moulded_component;
		MoveL p50, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p60, p70, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p80, p90, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p100, p110, v500, fine, pen\WObj:=injection_moulded_component;
		MoveL p120, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p130, p140, v500, fine, pen\WObj:=injection_moulded_component;
		MoveL p150, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p160, p170, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p180, p190, v500, fine, pen\WObj:=injection_moulded_component;
		MoveC p200, p210, v500, fine, pen\WObj:=injection_moulded_component;
		TPWrite "The sealant applied";
		MoveJ above_holder, v600, fine, pen\WObj:=pen_holder;
		MoveL holder, v600, fine, pen\WObj:=pen_holder;
		! opengripper
		WaitTime 2;
		TPWrite "Returned the tool";
		ClkStop clock1;
		time := ClkRead(clock1);
		TPWrite "Cycle time of last product is "\Num:=time;
		MoveL above_holder, v600, fine, pen\WObj:=pen_holder;
		ClkStop clock2;
		total_time := ClkRead(clock2);
		TPWrite "Cycle time of last loop is "\Num:=total_time;
	ENDPROC
ENDMODULE