clc
close all
clear all

f= imread('G5kyu.png');
f = int16(f);
set(0,'RecursionLimit',2000)
figure,
subplot(2,1,1);
imshow(f);
title('original Figure')

[x,y] = size(f);
global mark_pixel;
mark_pixel=zeros(x,y);
%visited_pixel = zeros(x,y);
global current_region;
current_region = zeros(x,y);
global img;
img = f;
region_id = 0;
for i=1:x
    for j=1:y
        
        intensity_pixel = img(i,j);
        if(mark_pixel(i,j)==0)
            region_id=region_id+1;
            current_region(i,j)=region_id;
        end
        mark_pixel(i,j)=1;
        %new_region = visited_pixel;
        %process Neighborhood
        process_neighbor(intensity_pixel,i,j,x,y,region_id);
        
        
    end
end

% Procedure for Building Reegion adjacency Graph

num_vertices = max(max(current_region));
v =zeros(num_vertices,2);
g = sparse(num_vertices,num_vertices); %This produces g(m(region1),n(region2))
                                        %(2,3) regions and label is 10
                                        %suppose
for i=1:num_vertices
    
    lin_ind_reg = find(current_region == i);
    
    lin_ind_img = find(f);
    % relative size of region
    
    rel_size = size(lin_ind_reg,1)/size(lin_ind_img,1);
    
    % Set average pixel value surrounded by the Region
     
    avg_pixel = round(sum(f(lin_ind_reg))/size(lin_ind_reg,1));
    v(i,1) =rel_size;
    v(i,2) = avg_pixel; %label for vertices
end
    
    for i1=1:size(current_region,1)
        for j1=1:size(current_region,2)
            
           if j1<=255
                
                m = current_region(i1,j1);
                
                n = current_region(i1,j1+1);%size out of bounds as i1+1=257
                if(m~=n)
                    if g(m,n) == 0
                        g(m,n) =1;
                        g(m,n)=abs(v(m,2) -v(n,2)); % Label of edge
                    elseif g(n,m) ==0
                        g(n,m) =1;
                        g(n,m)=abs(v(m,2) -v(n,2)); % Label of edge
                    
                    end
                end
           end
           if i1<=255
                n = current_region(i1+1,j1);
                if(m~=n)
                    if g(m,n) == 0
                        g(m,n) =1;
                        g(m,n)=abs(v(m,2) -v(n,2)); % Label of edge
                    elseif g(n,m) ==0
                        g(n,m) =1;
                        g(n,m)=abs(v(m,2) -v(n,2)); % Label of edge
                    
                    end
                end
           end
            
        end
    end
    
%Its looking for the slices in the regions every time we search for 
%suppose search for the 1:2,2:8 it would give (1,1) 1 and (2,2) 1
%that is an edge between the same region but it is not same it is just
%start looking at this location just look picture of white board in your
%for more clear discussion.

