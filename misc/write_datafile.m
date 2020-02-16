function [ res ] = write_datafile( fn, x )
%WRITE_DATAFILE Summary of this function goes here
%  fn : file name
%   x : the input, Nrow * Ncol matrix
%   

[Nrow,Ncol] = size(x);

fido = fopen(fn,'wt');

if size(x,2) == 1
    fprintf(fido,'%d\n',x);
else
    for i = 1:Nrow
        for j = 1:Ncol-1
            fprintf(fido,'%d\t',x(i,j));
        end
        fprintf(fido,'%d\n',x(i,Ncol));
    end
end
fclose(fido);

end

