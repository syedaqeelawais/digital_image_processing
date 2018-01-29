function [  ] = process_neighbor(intensity_pixel,a,b,x,y,id)
%UNTITLED2 Summary of this function goes here
global img;
global mark_pixel;
global current_region;
%   Detailed explanation goes here
    for t=0:3;
        
    theta=t*pi/2;
   % h=x;
    
    neighbor = [a+round(cos(theta)) b+round(sin(theta))];
    
    if(neighbor(1)>= 1 && neighbor(2)>=1 && neighbor(1)<=x && neighbor(2)<=y)
    %[k l] =size(neighbor);
        %if visited_pixel(k,l)==0 && abs([x1 y1] - [k l]) <= 0;
        
        if(mark_pixel(neighbor(1),neighbor(2)) == 0 && abs(intensity_pixel - img(neighbor(1),neighbor(2))) <= 0)
       % visited_pixel(k,l) = 1;
        mark_pixel(neighbor(1),neighbor(2))=1;
        current_region(neighbor(1),neighbor(2)) = id;
        process_neighbor(intensity_pixel,neighbor(1),neighbor(2),x,y,id);
        
        end
    end
    
    end
end

