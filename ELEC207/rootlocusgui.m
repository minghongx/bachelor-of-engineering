function rootlocusgui(param)
% ROOTLOCUSGUI is a MATLAB GUI to help ELEC207 students understand root
% locus. Call the function with no arguments to initiate the GUI
%
% The controls should be self-explanatory, but (noting that you may 
% need to maximise the window to see all the buttons):
%
% Type in the box to the right of where it says 'ZEROS' to specify a matrix of where the open-loop zeros are
% Type in the box to the right of where it says 'POLES' to specify a matrix of where the open-loop poles are
% Type in the box to the right of 'K' to set the value of the gain
% Press '+' makes the gain bigger
% Press '-' makes the gain smaller
% Type in the box to the right of 'AXIS' to specify the axis extent in terms of [xmin, xmax, ymin, ymax]
% Press 'SHOW' to toggle whether the whole root locus is shown or just the closed
% loop poles for the current gain
%
% Written by Simon Maskell on 3 March 2014
% Modified by Minghong Xu in March 2022

if(nargin<1)
    rootlocusgui('start')
    return;
end
switch(param)
    case 'start'
        clf
        uicontrol('style','text','position',[0 0 50 20],'string','Zeros');
        userdata.zeros = uicontrol('style','edit','position',[60 0 100 20],'string',[5],'callback','rootlocusgui(''update'')');
        uicontrol('style','text','position',[170 0 50 20],'string','Poles');
        userdata.poles = uicontrol('style','edit','position',[230 0 100 20],'string',[-5],'callback','rootlocusgui(''update'')');
        uicontrol('style','text','position',[340 0 50 20],'string','K');
        userdata.K = uicontrol('style','edit','position',[400 0 100 20],'string','1','callback','rootlocusgui(''update'')');
        userdata.MoreK = uicontrol('style','pushbutton','position',[510 0 20 20],'string','+','callback','rootlocusgui(''increaseK'')');
        userdata.LessK = uicontrol('style','pushbutton','position',[530 0 20 20],'string','-','callback','rootlocusgui(''decreaseK'')');
        uicontrol('style','text','position',[560 0 50 20],'string','axis');
        userdata.axis = uicontrol('style','edit','position',[620 0 100 20],'string','[-10 10 -10 10]','callback','rootlocusgui(''redisplay'')');
        userdata.showlocus = uicontrol('style','pushbutton','position',[730 0 100 20],'string','Show','callback','rootlocusgui(''toggleshow'')');
        userdata.showinglocus = 0;
        set(gcf,'userdata',userdata);
        pause(0.1);
        userdata = recalculaterootlocus(userdata);
        plotpolesandzeros(userdata);
    case 'toggleshow'
        userdata = get(gcf,'userdata');
        userdata.showinglocus = ~userdata.showinglocus;
        set(gcf,'userdata',userdata);
        plotpolesandzeros(userdata);        
    case 'redisplay'
        %assumes no change to what to draw
        plotpolesandzeros(userdata);        
    case 'update'
        userdata = get(gcf,'userdata');
        %check that there aren't more zeros than poles; if there are too
        %many zeros, kill off the excess, display a warning and crack on
        p = str2num(get(userdata.poles,'string'));
        z = str2num(get(userdata.zeros,'string'));
        if(length(z)>length(p))
            set(userdata.zeros,'string',sprintf('%f',z(1:length(p))));
            disp('warning: excessively many zeros - last ones removed');
        end
        userdata = recalculaterootlocus(userdata);
        plotpolesandzeros(userdata)
    case 'increaseK'
        userdata = get(gcf,'userdata');
        K = str2num(get(userdata.K,'string'));
        Knew = K*1.5;
        set(userdata.K,'string',sprintf('%f',Knew));
        plotpolesandzeros(userdata);
    case 'decreaseK'
        userdata = get(gcf,'userdata');
        K = str2num(get(userdata.K,'string'));
        Knew = K/1.5;
        set(userdata.K,'string',sprintf('%f',Knew));
        plotpolesandzeros(userdata);
end

%------------------------------------------------------------------------------------------
function plotpolesandzeros(userdata)

ax = str2num(get(userdata.axis,'string'));
cla
axis(ax);
K = str2num(get(userdata.K,'string'));
z = str2num(get(userdata.zeros,'string'));
p = str2num(get(userdata.poles,'string'));
%open loop poles
plot(real(z),imag(z),'bo','markersize',30,'linewidth',3)
xlabel('Re(s)')
ylabel('Im(s)')
hold on;
plot(real(p),imag(p),'bx','markersize',30,'linewidth',3)

%closed loop poles
currentclosedlooppoles = roots([poly(p)+K*[zeros(1,length(p)-length(z)) poly(z)]]);
% roots(poly(... 忽视了 coefficient scaling. poly() 只会返回一组可能的
% coefficients 而忽略 scaling. open loop tansfer function = Z(s)/P(s) 中
% polynomial Z(s) 与 P(s) 的 coefficients 不能被随意 scale, 因为这影响
% characteristic equation, P(s) + K*Z(s) = 0, 也就是影响 closed loop poles 的位置.
% Reference
% The poly function converts the roots back to polynomial coefficients. 
% When operating on vectors, poly and roots are inverse functions, such 
% that poly(roots(p)) returns p (up to roundoff error, ordering, and scaling).
% Available: https://uk.mathworks.com/help/matlab/math/roots-of-polynomials.html
plot(real(currentclosedlooppoles),imag(currentclosedlooppoles),'x','color','r','markersize',30,'linewidth',3)
if(userdata.showinglocus)
    plot(real(userdata.closedlooppoles),imag(userdata.closedlooppoles),'.','color','r','markersize',20,'linewidth',3)
end
%axes
plot(ax(1:2),[0 0],'b:','linewidth',3,'color','k')
plot([0 0], ax(3:4),'b:','linewidth',3,'color','k')

%------------------------------------------------------------------------------------------
function userdata = recalculaterootlocus(userdata)

p = str2num(get(userdata.poles,'string'));
z = str2num(get(userdata.zeros,'string'));

n = 200;
Kpossible = logspace(-5,5,n);
userdata.closedlooppoles = zeros(length(p),n);
for i=1:n
	userdata.closedlooppoles(:,i) = roots([poly(p)+Kpossible(i)*[zeros(1,length(p)-length(z)) poly(z)]]);  % 与 line 94 一样的错
end
set(gcf,'userdata',userdata);
