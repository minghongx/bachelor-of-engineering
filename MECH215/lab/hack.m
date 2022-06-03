clear;
close all;



run_times = 13;
step = (4-0.4)/(run_times-1);

% 1: No damping
% 2: Low damping
% 3: Intermediate damping
% 4: Critical damping
% 5: Large (over)damping
damping = 2;
i = [];  % 4.2.i result
for run_num=1:run_times
    i = [i; sin_response(damping, 0.4 + (run_num-1)*step, run_num)];
end

damping = 4;  % Critical damping
ii = [];  % 4.2.ii result
for run_num=1:run_times
    ii = [ii; sin_response(damping, 0.4 + (run_num-1)*step, run_num)];
end

damping = 3;  % Intermediate damping
iii = [];  % 4.2.iii result
for run_num=1:run_times
    iii = [iii; sin_response(damping, 0.4 + (run_num-1)*step, run_num)];
end



function row = sin_response(jj2, Hz, run_num)

ome_0 = 2*pi*Hz;

%% Fuck GUI

st_num = 201601082;

% run_num = 1;

% case of study: Sinsoidale (harmonic) forced response
study = 2;
% ome_0 = 0.4;  % input frequency (rad/s)
x_init = 0;

% ch{1} = 'No damping';
% ch{2} = 'Low damping';
% ch{3} = 'Intermediate damping';
% ch{4} = 'Critical damping';
% ch{5} = 'Large (over)damping';
% jj2 = ;

if jj2 ==1
    xi = 0.001;
elseif jj2==2
 %   xi = 0.2;  % real lab value
    xi = 0.05;
elseif jj2==3
 %   xi = 0.31;  % real lab value
    xi = 0.25;
elseif jj2==4
    xi=1;
elseif jj2==5
    xi=3;
end

% simulation duration (in seconds bewteen 5s and 20s)
t_end = 10;

% No animation
anim = 2;



%% data

rng(st_num); 


m = 4.1 ;
k = 1100*(1 + 0.2*2*(rand - 0.5)); % +/- 20%
%c = 27;

c = 2*xi*sqrt(m*k);
%anim = 1;
%% generation of random friction force (random field indexed by the vertical position)

rng(st_num+run_num); % from now the seed depends also on the run number

xxx = -1:0.001:1;
Lc = 0.01;
rand_fric = exp(makeGauss1D( 'sinc2', xxx', Lc, 1 ));

%%

ome_n = sqrt(k/m);

xi = c/(2*sqrt(m*k));

%t_end = 5;

dt = 0.001;

%study = 2; % 1 for free response, 2 for forced response

%ome_0 = 15.7;
%x_init = -0.1;

%% simulation

t_end_b = 70;

t_vector = 0:dt:t_end;   % vector containing the time increments
nb_t = length(t_vector);  % number of time steps

t_vector_b = 0:dt:t_end_b;   % vector containing the time increments
nb_t_b = length(t_vector_b);  % number of time steps

input_amplitude = 0.0063*4;
y = input_amplitude*sin(ome_0*t_vector_b);

if study == 1
    y=y*0;
end

x=zeros(1,nb_t_b);
xdot=zeros(1,nb_t_b);

x(1) = x_init;
f_fric=zeros(1,nb_t_b);

uuu = waitbar(0,'Please wait','Name','Calculating the response...',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

setappdata(uuu,'canceling',0);

ind_bar = 0;
for ii=1:(nb_t_b-1)
    if getappdata(uuu,'canceling')
        break
    end

    f = k*y(ii);
    f_fr_interp = interp1(xxx',rand_fric,x(ii),'nearest');
   % f_fr_interp = 0;
    f_fric(ii+1) = -f_fr_interp*sign(xdot(ii))/70;
    xdot(ii+1) = xdot(ii) + dt*(-k*x(ii) - c*xdot(ii) + f +f_fric(ii+1))/m;
    x(ii+1) = x(ii) + dt*xdot(ii+1);
    
    
    if ind_bar ==1000
        waitbar(ii/nb_t_b,uuu,'Please wait')
        ind_bar=0;
    end
    ind_bar = ind_bar+1;
    
end
delete(uuu);

x = x + randn(1,nb_t_b)*0.0001;    % include measurement noise

%% animation

if anim==1
    jump = 10;
    v_time = 1:jump:nb_t;
    n_time = length(v_time);
    
    Loc_1 = [0,0,0];
    Loc_2 = [0,0,0.4];
    Loc_3 = [0,0,-0.3];
    
    %cylinder 1
    Radius = 0.05;
    Height = 0.02;
    SideCount = 50;
    Color = 'm';
    
    VertexData1 = zeros(2*SideCount,3,n_time);
    PatchData1_X = zeros(4,SideCount,n_time);
    PatchData1_Y = zeros(4,SideCount,n_time);
    PatchData1_Z = zeros(4,SideCount,n_time);
    PatchData2_X = zeros(SideCount,2,n_time);
    PatchData2_Y = zeros(SideCount,2,n_time);
    PatchData2_Z = zeros(SideCount,2,n_time);
    
    
    % Compute propagation of vertices and patches for cylinders
    
    for i_time=1:n_time
        
        VertexData1(:,:,i_time) = GeoVer_Cylind(Loc_1 + [0,0,x(v_time(i_time))],eye(3),eye(3),Radius,Radius,Height,SideCount,[0,0,0]);
        [X1,Y1,Z1,X2,Y2,Z2] = GeoPat_Cylind(VertexData1(:,:,i_time),SideCount);
        PatchData1_X(:,:,i_time) = X1;
        PatchData1_Y(:,:,i_time) = Y1;
        PatchData1_Z(:,:,i_time) = Z1;
        PatchData2_X(:,:,i_time) = X2;
        PatchData2_Y(:,:,i_time) = Y2;
        PatchData2_Z(:,:,i_time) = Z2;
    end
    
    PatchCylind1_X = PatchData1_X;
    PatchCylind1_Y = PatchData1_Y;
    PatchCylind1_Z = PatchData1_Z;
    PatchCylind2_X = PatchData2_X;
    PatchCylind2_Y = PatchData2_Y;
    PatchCylind2_Z = PatchData2_Z;
    
    maxx = max(max(max(max(PatchData1_X))));
    minx = min(min(min(min(PatchData1_X))));
    maxy = max(max(max(max(PatchData1_Y))));
    miny = min(min(min(min(PatchData1_Y))));
    maxz = max(max(max(max(PatchData1_Z))));
    minz = min(min(min(min(PatchData1_Z))));
    
    %cylinder 2
    
    Radius = 0.03;
    Height = 0.01;
    SideCount = 50;
    Color2 = 'k';
    
    VertexData1_2 = zeros(2*SideCount,3,n_time);
    PatchData1_X_2 = zeros(4,SideCount,n_time);
    PatchData1_Y_2 = zeros(4,SideCount,n_time);
    PatchData1_Z_2 = zeros(4,SideCount,n_time);
    PatchData2_X_2 = zeros(SideCount,2,n_time);
    PatchData2_Y_2 = zeros(SideCount,2,n_time);
    PatchData2_Z_2 = zeros(SideCount,2,n_time);
    
    
    % Compute propagation of vertices and patches for cylinders
    
    for i_time=1:n_time
        
        VertexData1_2(:,:,i_time) = GeoVer_Cylind(Loc_2+ [0,0,y(v_time(i_time))],eye(3),eye(3),Radius,Radius,Height,SideCount,[0,0,0]);
        [X1,Y1,Z1,X2,Y2,Z2] = GeoPat_Cylind(VertexData1_2(:,:,i_time),SideCount);
        PatchData1_X_2(:,:,i_time) = X1;
        PatchData1_Y_2(:,:,i_time) = Y1;
        PatchData1_Z_2(:,:,i_time) = Z1;
        PatchData2_X_2(:,:,i_time) = X2;
        PatchData2_Y_2(:,:,i_time) = Y2;
        PatchData2_Z_2(:,:,i_time) = Z2;
    end
    
    PatchCylind1_X_2 = PatchData1_X_2;
    PatchCylind1_Y_2 = PatchData1_Y_2;
    PatchCylind1_Z_2 = PatchData1_Z_2;
    PatchCylind2_X_2 = PatchData2_X_2;
    PatchCylind2_Y_2 = PatchData2_Y_2;
    PatchCylind2_Z_2 = PatchData2_Z_2;
    
    maxx = max(maxx,max(max(max(PatchData1_X_2))));
    minx = min(minx,min(min(min(PatchData1_X_2))));
    maxy = max(maxy,max(max(max(PatchData1_Y_2))));
    miny = min(miny,min(min(min(PatchData1_Y_2))));
    maxz = max(maxz,max(max(max(PatchData1_Z_2))));
    minz = min(minz,min(min(min(PatchData1_Z_2))));
    
    
    % spring
    
    Radius = 0.02;
    Nspires = 20;
    Nstep = 40;
    Color_3 = 'g';
    
    Nbptt = (Nstep*Nspires+1);
    VertexData_3 = zeros(Nbptt,3,n_time);
    Connect = [1:(Nbptt-1);2:(Nbptt)]';
    
    % Compute propagation of vertices and patches for cylinders
    
    for i_time=1:n_time
        
        VertexData_3(:,:,i_time) = GeoVer_Spring(Loc_1+ [0,0,x(v_time(i_time))],Loc_2+ [0,0,y(v_time(i_time))],eye(3),eye(3),Radius,Nspires,Nstep,[0,0,0],[0,0,0])';
    end
    
    
    
    % damper
    
    R_main = 0.04;
    R_s = 0.01;
    L_main = 0.15;
    SideCount = 20;
    Color_4 = 'b';
    
    VertexData11 = zeros(2*SideCount,3,n_time);
    PatchData11_X = zeros(4,SideCount,n_time);
    PatchData11_Y = zeros(4,SideCount,n_time);
    PatchData11_Z = zeros(4,SideCount,n_time);
    PatchData12_X = zeros(SideCount,2,n_time);
    PatchData12_Y = zeros(SideCount,2,n_time);
    PatchData12_Z = zeros(SideCount,2,n_time);
    
    VertexData21 = zeros(2*SideCount,3,n_time);
    PatchData21_X = zeros(4,SideCount,n_time);
    PatchData21_Y = zeros(4,SideCount,n_time);
    PatchData21_Z = zeros(4,SideCount,n_time);
    PatchData22_X = zeros(SideCount,2,n_time);
    PatchData22_Y = zeros(SideCount,2,n_time);
    PatchData22_Z = zeros(SideCount,2,n_time);
    
    % Compute propagation of vertices and patches for dampers
    PT1 = Loc_1;
    PT2 = Loc_3;
    
    L0 = sqrt(sum((PT1-PT2).^2));
    
    for i_time=1:n_time
        
        [VertexData11(:,:,i_time),VertexData21(:,:,i_time)] = GeoVer_Damper(Loc_1+ [0,0,x(v_time(i_time))],Loc_3,eye(3),eye(3),R_main,R_s,L_main,L0,SideCount,[0,0,0],[0,0,0]);
        [X11,Y11,Z11,X12,Y12,Z12] = GeoPat_Cylind(VertexData11(:,:,i_time),SideCount);
        [X21,Y21,Z21,X22,Y22,Z22] = GeoPat_Cylind(VertexData21(:,:,i_time),SideCount);
        PatchData11_X(:,:,i_time) = X11;
        PatchData11_Y(:,:,i_time) = Y11;
        PatchData11_Z(:,:,i_time) = Z11;
        PatchData12_X(:,:,i_time) = X12;
        PatchData12_Y(:,:,i_time) = Y12;
        PatchData12_Z(:,:,i_time) = Z12;
        PatchData21_X(:,:,i_time) = X21;
        PatchData21_Y(:,:,i_time) = Y21;
        PatchData21_Z(:,:,i_time) = Z21;
        PatchData22_X(:,:,i_time) = X22;
        PatchData22_Y(:,:,i_time) = Y22;
        PatchData22_Z(:,:,i_time) = Z22;
    end
    
    PatchCylind11_X = PatchData11_X;
    PatchCylind11_Y = PatchData11_Y;
    PatchCylind11_Z = PatchData11_Z;
    PatchCylind12_X = PatchData12_X;
    PatchCylind12_Y = PatchData12_Y;
    PatchCylind12_Z = PatchData12_Z;
    
    PatchCylind21_X = PatchData21_X;
    PatchCylind21_Y = PatchData21_Y;
    PatchCylind21_Z = PatchData21_Z;
    PatchCylind22_X = PatchData22_X;
    PatchCylind22_Y = PatchData22_Y;
    PatchCylind22_Z = PatchData22_Z;
    
    
    maxx = max(maxx,max(max(max(PatchData11_X))));
    minx = min(minx,min(min(min(PatchData11_X))));
    maxy = max(maxy,max(max(max(PatchData11_Y))));
    miny = min(miny,min(min(min(PatchData21_Y))));
    maxz = max(maxz,max(max(max(PatchData11_Z))));
    minz = min(minz,min(min(min(PatchData21_Z))));
    maxx = max(maxx,max(max(max(PatchData21_X))));
    minx = min(minx,min(min(min(PatchData21_X))));
    maxy = max(maxy,max(max(max(PatchData21_Y))));
    miny = min(miny,min(min(min(PatchData21_Y))));
    maxz = max(maxz,max(max(max(PatchData21_Z))));
    minz = min(minz,min(min(min(PatchData21_Z))));
    
    
    %cylinder 3
    Radius = 0.035;
    Height = 0.02;
    SideCount = 50;
    Color5 = 'b';
    
    VertexData1 = zeros(2*SideCount,3,n_time);
    PatchData1_X = zeros(4,SideCount,n_time);
    PatchData1_Y = zeros(4,SideCount,n_time);
    PatchData1_Z = zeros(4,SideCount,n_time);
    PatchData2_X = zeros(SideCount,2,n_time);
    PatchData2_Y = zeros(SideCount,2,n_time);
    PatchData2_Z = zeros(SideCount,2,n_time);
    
    
    % Compute propagation of vertices and patches for cylinders
    
    for i_time=1:n_time
        
        VertexData1(:,:,i_time) = GeoVer_Cylind(Loc_3 + [0,0,x(v_time(i_time))] + [0,0,L_main/2],eye(3),eye(3),Radius,Radius,Height,SideCount,[0,0,0]);
        [X1,Y1,Z1,X2,Y2,Z2] = GeoPat_Cylind(VertexData1(:,:,i_time),SideCount);
        PatchData1_X(:,:,i_time) = X1;
        PatchData1_Y(:,:,i_time) = Y1;
        PatchData1_Z(:,:,i_time) = Z1;
        PatchData2_X(:,:,i_time) = X2;
        PatchData2_Y(:,:,i_time) = Y2;
        PatchData2_Z(:,:,i_time) = Z2;
    end
    
    PatchCylind1_X_3 = PatchData1_X;
    PatchCylind1_Y_3 = PatchData1_Y;
    PatchCylind1_Z_3 = PatchData1_Z;
    PatchCylind2_X_3 = PatchData2_X;
    PatchCylind2_Y_3 = PatchData2_Y;
    PatchCylind2_Z_3 = PatchData2_Z;
    
    
    
    figure(5); hold on;
    view([30,30])
    
    alpha = 0.8;
    % deltx = abs(maxx-minx);
    % delty = abs(maxy-miny);
    % deltz = abs(maxz-minz);
    %
    % minx = minx - alpha*deltx;
    % maxx = maxx + alpha*deltx;
    % miny = miny - alpha*delty;
    % maxy = maxy + alpha*delty;
    % minz = minz - alpha*deltz;
    % maxz = maxz + alpha*deltz;
    
    
    
    xlim([minx,maxx]);
    ylim([miny,maxy]);
    zlim([minz,maxz]);
    
    h1 = patch(PatchCylind1_X(:,:,1),PatchCylind1_Y(:,:,1),PatchCylind1_Z(:,:,1),Color);
    set(h1,'FaceLighting','phong','EdgeLighting','phong');
    h2 = patch(PatchCylind2_X(:,:,1),PatchCylind2_Y(:,:,1),PatchCylind2_Z(:,:,1),Color);
    set(h2,'FaceLighting','phong','EdgeLighting','phong');
    
    h3 = patch(PatchCylind1_X_2(:,:,1),PatchCylind1_Y_2(:,:,1),PatchCylind1_Z_2(:,:,1),Color2);
    set(h3,'FaceLighting','phong','EdgeLighting','phong');
    h4 = patch(PatchCylind2_X_2(:,:,1),PatchCylind2_Y_2(:,:,1),PatchCylind2_Z_2(:,:,1),Color2);
    set(h4,'FaceLighting','phong','EdgeLighting','phong');
    
    h5=patch('faces',Connect(:,:,1),'vertices',VertexData_3(:,:,1),'FaceAlpha',0.2,'FaceColor',Color_3,'EdgeColor',Color_3,'LineWidth', 2.0);
    
    h6 = patch(PatchCylind11_X(:,:,1),PatchCylind11_Y(:,:,1),PatchCylind11_Z(:,:,1),Color_4,'EdgeColor',Color_4);
    set(h6,'FaceLighting','phong','EdgeLighting','phong');
    h7 = patch(PatchCylind12_X(:,:,1),PatchCylind12_Y(:,:,1),PatchCylind12_Z(:,:,1),Color_4,'EdgeColor',Color_4);
    set(h7,'FaceLighting','phong','EdgeLighting','phong');
    
    h8 = patch(PatchCylind21_X(:,:,1),PatchCylind21_Y(:,:,1),PatchCylind21_Z(:,:,1),'c','EdgeColor','c');
    set(h8,'FaceLighting','phong','EdgeLighting','phong');
    %h9 = patch(PatchCylind22_X(:,:,1),PatchCylind22_Y(:,:,1),PatchCylind22_Z(:,:,1),'c','EdgeColor','c');
    %set(h9,'FaceLighting','phong','EdgeLighting','phong');
    
    h10 = patch(PatchCylind1_X_3(:,:,1),PatchCylind1_Y_3(:,:,1),PatchCylind1_Z_3(:,:,1),Color5);
    set(h10,'FaceLighting','phong','EdgeLighting','phong');
    h11 = patch(PatchCylind2_X_3(:,:,1),PatchCylind2_Y_3(:,:,1),PatchCylind2_Z_3(:,:,1),Color5);
    set(h11,'FaceLighting','phong','EdgeLighting','phong');
    
    axis equal
    
    axis vis3d equal;
    camlight;
    
    xlim([minx,maxx]);
    ylim([miny,maxy]);
    zlim([minz,maxz]);
    
    hold off;
    
    for i_time=1:n_time
        
        set(h1,'XData',PatchCylind1_X(:,:,i_time));
        set(h1,'YData',PatchCylind1_Y(:,:,i_time));
        set(h1,'ZData',PatchCylind1_Z(:,:,i_time));
        set(h2,'XData',PatchCylind2_X(:,:,i_time));
        set(h2,'YData',PatchCylind2_Y(:,:,i_time));
        set(h2,'ZData',PatchCylind2_Z(:,:,i_time));
        
        set(h3,'XData',PatchCylind1_X_2(:,:,i_time));
        set(h3,'YData',PatchCylind1_Y_2(:,:,i_time));
        set(h3,'ZData',PatchCylind1_Z_2(:,:,i_time));
        set(h4,'XData',PatchCylind2_X_2(:,:,i_time));
        set(h4,'YData',PatchCylind2_Y_2(:,:,i_time));
        set(h4,'ZData',PatchCylind2_Z_2(:,:,i_time));
        
        
        set(h5,'Vertices',VertexData_3(:,:,i_time));
        
        set(h6,'XData',PatchCylind11_X(:,:,i_time));
        set(h6,'YData',PatchCylind11_Y(:,:,i_time));
        set(h6,'ZData',PatchCylind11_Z(:,:,i_time));
        set(h7,'XData',PatchCylind12_X(:,:,i_time));
        set(h7,'YData',PatchCylind12_Y(:,:,i_time));
        set(h7,'ZData',PatchCylind12_Z(:,:,i_time));
        
        set(h8,'XData',PatchCylind21_X(:,:,i_time));
        set(h8,'YData',PatchCylind21_Y(:,:,i_time));
        set(h8,'ZData',PatchCylind21_Z(:,:,i_time));
        %    set(h9,'XData',PatchCylind22_X(:,:,i_time));
        %    set(h9,'YData',PatchCylind22_Y(:,:,i_time));
        %    set(h9,'ZData',PatchCylind22_Z(:,:,i_time));
        
        set(h10,'XData',PatchCylind1_X_3(:,:,i_time));
        set(h10,'YData',PatchCylind1_Y_3(:,:,i_time));
        set(h10,'ZData',PatchCylind1_Z_3(:,:,i_time));
        set(h11,'XData',PatchCylind2_X_3(:,:,i_time));
        set(h11,'YData',PatchCylind2_Y_3(:,:,i_time));
        set(h11,'ZData',PatchCylind2_Z_3(:,:,i_time));
        
        title(['t = ' num2str(t_vector(v_time(i_time))) ' s']);
        drawnow;pause(0.001);
        
        
    end
    
end


%% results analysis

if study == 2
    x_ss = x(floor(nb_t_b*3/4):end);
    [b,a] = butter(4,0.1,'low');           % IIR filter design
    x_ss = filtfilt(b,a,x_ss);                    % zero-phase filtering

    output_amplitude = max(abs(x_ss));
    amplitude_ratio = output_amplitude/input_amplitude;
    
    fmax = 10;
    [ff1,rep_out] = calc_fft(t_vector_b,x,fmax);
    [ff2,rep_in] = calc_fft(t_vector_b,y,fmax);
    
    [mag_x, idx_x] = max(abs(rep_in));
    [mag_y, idx_y] = max(abs(rep_out));
    % determine the phase difference
    % at the maximum point.
    px = unwrap(angle(rep_in(idx_x)));
    py = unwrap(angle(rep_out(idx_y)));
    
    phase_lag = py - px;
    if phase_lag>pi
        phase_lag = phase_lag - 2*pi;
    end
    time_lag = phase_lag/ome_0;
else
    ome_d = ome_n*sqrt(1-xi^2);
    Td = 2*pi/ome_d;   
    if x_init>0
        tt1 = Td;
        tt2 = 2*Td;
        tt3 = 3*Td;
    else
        tt1 = 0.5*Td;
        tt2 = 1.5*Td;
        tt3 = 2.5*Td;
    end
    if xi<1
        [~,idx1]=min(abs(t_vector-tt1));
        iddb = (idx1-50):(idx1+50);
        [val1,idx]=max(x(iddb));
        idx1 = iddb(idx);
        tt1 = t_vector(idx1);
        Val1=x(idx1);
        [~,idx2]=min(abs(t_vector-tt2));
        iddb = (idx2-50):(idx2+50);
        [val2,idx]=max(x(iddb));
        idx2 = iddb(idx);
        tt2 = t_vector(idx2);
        Val2=x(idx2);
        [~,idx3]=min(abs(t_vector-tt3));
        iddb = (idx3-50):(idx3+50);
        [val3,idx]=max(x(iddb));
        idx3 = iddb(idx);
        tt3 = t_vector(idx3);
        Val3=x(idx3);
    end

end

row = [Hz, ome_0, amplitude_ratio, phase_lag];

figure(1);
if study==2
    plot(t_vector, x(1:nb_t)*1000,'b'); hold on;   % plot of the damped displacement
    plot(t_vector, y(1:nb_t)*1000,'r'); hold on;   % plot of the damped displacement
    plot(t_vector, y(1:nb_t)*1000*0,'k'); hold off;   % plot of the damped displacement
    title('Forced response')
    legend(['0utput - amplitude: ' num2str((1000*output_amplitude)) ' mm'],...
        ['Input - amplitude: ' num2str((1000*input_amplitude)) ' mm'],...
        ['Phase difference: ' num2str((phase_lag)) ' rad (' num2str((time_lag)) ' s)'], 'location', 'SouthEast');
else
    plot(t_vector, x(1:nb_t)*1000,'b'); hold on;   % plot of the damped displacement
    if(xi<1)
        plot(t_vector(1:idx1), ones(1,idx1)*Val1*1000,'--r'); hold on;   % plot of the damped displacement
        plot(t_vector(1:idx2), ones(1,idx2)*Val2*1000,'--r'); hold on;   % plot of the damped displacement
        plot(t_vector(1:idx3), ones(1,idx3)*Val3*1000,'--r'); hold on;   % plot of the damped displacement
        plot([t_vector(idx1) t_vector(idx1)], [0 Val1*1000 ],'--r'); hold on;   % plot of the damped displacement
        plot([t_vector(idx2) t_vector(idx2)], [0 Val2*1000 ],'--r'); hold on;   % plot of the damped displacement
        plot([t_vector(idx3) t_vector(idx3)], [0 Val3*1000 ],'--r'); hold off;   % plot of the damped displacement
        hold off;
        title('Free response')
        legend(['0utput:' newline 'First peak - Time: ' num2str(tt1) ' s; ' 'Value: ' num2str((Val1*1000)) ' mm;'...
            newline 'Second peak - Time: ' num2str(tt2) ' s; ' 'Value: ' num2str((Val2*1000)) ' mm;'...
            newline 'Third peak - Time: ' num2str(tt3) ' s; ' 'Value: ' num2str((Val3*1000)) ' mm;'], 'location', 'SouthEast');
        
    else
    %    plot(t_vector(1:idx1), ones(1,idx1)*Val1*1000,'--r'); hold on;   % plot of the damped displacement
        title('Free response')
        legend('0utput' , 'location', 'SouthEast');
    end
end
xlabel('Time (s)','FontSize',10)
ylabel('Displacement (mm)','FontSize',10)
hgh=gca;
set(gca,'FontSize',10)
grid on;

end

%% functions
function [ff,yy_fft] = calc_fft(t,y,fmax)

% Fourier transform for real functions. Time range has to start at zero.

if t(1)~=0
    error('t(1) has to be equal to zero');
end

if size(y,1)==1
    y=y';
end

if size(t,1)==1
    t=t';
end

Fs = 1/(t(2)-t(1));
Nsamps = length(t);
y_fft = (fft(y))/Fs;            %Retain Magnitude
y_fft = y_fft(1:floor(Nsamps/2+1),:);      %Discard Half of Points
f = Fs*(0:Nsamps/2)/Nsamps;   %Prepare freq data for plot

nmax = min(size(y_fft,1),ceil(length(t)*fmax/Fs));

ff = f(1:nmax);
yy_fft = y_fft(1:nmax,:);
end

function [VertexData1,VertexData2] = GeoVer_Damper(Location1,Location2,R1,R2,R_main,R_s,L_main,L0,SideCount,GB1,GB2)


r1 = Location1;
r2 = Location2;


PT1 = r1 + GB1*R1';
PT2 = r2 + GB2*R2';

H = sqrt(sum((PT1-PT2).^2));

%L_s = L0*0.98;
L_s = L0 - L_main/2;

% definition de la matrice de passage

Z_prime = (PT2-PT1)/H;
Y_prime = cross(Z_prime,[1 0 0]');
X_prime = cross(Y_prime,Z_prime);

Matrice_passage = [X_prime', Y_prime', Z_prime'];





% first cylinder

n_side = SideCount;


VertexData_0 = zeros(2*n_side,3);

for i_ver=1:n_side
    VertexData_0(i_ver,:) = [R_s*cos(2*pi/n_side*i_ver),R_s*sin(2*pi/n_side*i_ver),0];
    VertexData_0(n_side+i_ver,:) = [R_s*cos(2*pi/n_side*i_ver),R_s*sin(2*pi/n_side*i_ver),L_s];
end


VertexData1_tot = [VertexData_0(:,1),  VertexData_0(:,2), VertexData_0(:,3)]';
VertexData1_tot_new = Matrice_passage*VertexData1_tot;

n_ver = 2*n_side;

VertexData1 = zeros(n_ver,3);

VertexData1(:,1) = (VertexData1_tot_new(1,:) + PT1(1))';
VertexData1(:,2) = (VertexData1_tot_new(2,:) + PT1(2))';
VertexData1(:,3) = (VertexData1_tot_new(3,:) + PT1(3))';


% second cylinder

VertexData_0 = zeros(2*n_side,3);

for i_ver=1:n_side
    VertexData_0(i_ver,:) = [R_main*cos(2*pi/n_side*i_ver),R_main*sin(2*pi/n_side*i_ver),0];
    VertexData_0(n_side+i_ver,:) = [R_main*cos(2*pi/n_side*i_ver),R_main*sin(2*pi/n_side*i_ver),-L_main];
end


VertexData1_tot = [VertexData_0(:,1),  VertexData_0(:,2), VertexData_0(:,3)]';
VertexData1_tot_new = Matrice_passage*VertexData1_tot;

n_ver = 2*n_side;

VertexData2 = zeros(n_ver,3);

VertexData2(:,1) = (VertexData1_tot_new(1,:) + PT2(1))';
VertexData2(:,2) = (VertexData1_tot_new(2,:) + PT2(2))';
VertexData2(:,3) = (VertexData1_tot_new(3,:) + PT2(3))';


end


function VertexData = GeoVer_Spring(Location1,Location2,R1,R2,Radius,Nspires,Nstep,GB1,GB2)

% Cylinder specification

r1 = Location1;
r2 = Location2;

Nbptt = (Nstep*Nspires+1);

PT1 = r1 + GB1*R1';
PT2 = r2 + GB2*R2';

H = sqrt(sum((PT1-PT2).^2));

delt_a  =2*pi/Nstep;
pp = H/(Nstep*delt_a*Nspires);

X_spring = Radius*cos((0:(Nbptt-1))*delt_a);
Y_spring = Radius*sin((0:(Nbptt-1))*delt_a);
Z_spring = pp*((0:(Nbptt-1))*delt_a);

% definition de la matrice de passage

Z_prime = (PT2-PT1)/H;
Y_prime = cross(Z_prime,[1 0 0]');
X_prime = cross(Y_prime,Z_prime);

Matrice_passage = [X_prime', Y_prime', Z_prime'];



Coor_new = (Matrice_passage)*([X_spring;Y_spring;Z_spring]);
VertexData = Coor_new;
VertexData(1,:) = VertexData(1,:) + PT1(1);
VertexData(2,:) = VertexData(2,:) + PT1(2);
VertexData(3,:) = VertexData(3,:) + PT1(3);


end

function VertexData = GeoVer_Cylind(Location,Orientation,Orientation_ref,R_bottom,R_top,Height,SideCount,GB)

% Cylinder specification

r = Location;
R = Orientation;
R_ref = Orientation_ref;
R_tot = R*R_ref;

n_side = SideCount;

VertexData_0 = zeros(2*n_side,3);

for i_ver=1:n_side
    VertexData_0(i_ver,:) = [R_bottom*cos(2*pi/n_side*i_ver),R_bottom*sin(2*pi/n_side*i_ver),0];
    VertexData_0(n_side+i_ver,:) = [R_top*cos(2*pi/n_side*i_ver),R_top*sin(2*pi/n_side*i_ver),Height];
end

VertexData_0(:,1) = VertexData_0(:,1) ;
VertexData_0(:,2) = VertexData_0(:,2) ;
VertexData_0(:,3) = VertexData_0(:,3) -  (Height/4)*(3*R_top^2+ R_bottom^2 + 2*R_top*R_bottom)/(R_top^2+ R_bottom^2 +R_top*R_bottom) ;

VertexData_add(:,1) = VertexData_0(:,1)*0 +GB(1);
VertexData_add(:,2) = VertexData_0(:,2)*0 +GB(2);
VertexData_add(:,3) = VertexData_0(:,3)*0 +GB(3);

n_ver = 2*n_side;

VertexData = zeros(n_ver,3);

for i_ver=1:n_ver
    VertexData(i_ver,:) = r +VertexData_0(i_ver,:)*R_tot' + VertexData_add(i_ver,:)*R';
end


end

function [PatchData1_X,PatchData1_Y,PatchData1_Z,PatchData2_X,PatchData2_Y,PatchData2_Z] = GeoPat_Cylind(VertexData,SideCount)

n_side = SideCount;

% Side Patches
for i_pat=1:n_side-1
    Index_Patch1(i_pat,:) = [i_pat,i_pat+1,i_pat+1+n_side,i_pat+n_side];
end
Index_Patch1(n_side,:) = [n_side,1,1+n_side,2*n_side];

for i_pat=1:n_side
    
    % Side patches data
    PatchData1_X(:,i_pat) = VertexData(Index_Patch1(i_pat,:),1);
    PatchData1_Y(:,i_pat) = VertexData(Index_Patch1(i_pat,:),2);
    PatchData1_Z(:,i_pat) = VertexData(Index_Patch1(i_pat,:),3);
end

% Bottom Patches
Index_Patch2(1,:) = [1:n_side];
Index_Patch2(2,:) = [n_side+1:2*n_side];

for i_pat=1:2
    
    % Bottom patches data
    PatchData2_X(:,i_pat) = VertexData(Index_Patch2(i_pat,:),1);
    PatchData2_Y(:,i_pat) = VertexData(Index_Patch2(i_pat,:),2);
    PatchData2_Z(:,i_pat) = VertexData(Index_Patch2(i_pat,:),3);
end

end

function g = makeGauss1D( type, x, Lc, Nmc )
% generator of gaussian random field with unit variance and zero mean

% R. Cottereau 07/2010

% initialization
N = 2*size(x,1);
L = max(x,[],1)-min(x,[],1);
Lc = Lc/4/pi;

% state of the random generator
c = clock;
%rand( 'state', sum(c(end-3:end)) );

% generate samples of basic random variables
zbeta = sqrt( -log( rand(N,Nmc) ) );
phibeta = 2*pi * rand(N,Nmc);

% construction of random field in wavenumber space
k = (0:(N-1))'*2*pi/L;
switch type
    % triangle power spectrum = sinc^2 correlation
    case 'sinc2'
        Sk = Lc * tripuls( k, 2/Lc );     
end
Sk = repmat( sqrt( Sk ), [1 Nmc] );
gk = Sk .* zbeta .* exp( complex(0,1)*phibeta );
g = sqrt(2*pi/L)*N * ifft( gk, 'symmetric' );
g = g(1:N/2,:);

end

function y = tripuls(t,Tw,skew)

narginchk(1,3);

if nargin<2, Tw=1;   end
if nargin<3, skew=0; end


% Compute triangle function output:

y=zeros(size(t));
Ta=Tw/2*skew;
halfTw = Tw/2;

for i = 1:numel(t)
    if ((t(i) > (-halfTw) && (t(i) < Ta)))
        y(i) = (2*t(i)+Tw)./(Tw*(1+skew));
    elseif ((t(i) > Ta) && (t(i) < halfTw))
        y(i) = 1 - (2*t(i)-skew*Tw)./(Tw*(1-skew));
    elseif (t(i) == Ta)
        y(i) = 1.0;
    end
end
end
