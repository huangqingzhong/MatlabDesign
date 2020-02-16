function res = gen_hdl_test_datafile( fn, gap, bitwid, varargin )
%GEN_HDL_TEST_DATAFILE generate HDL-testing data and write to txt-file
%  fn : file name
%  gap : the gaps limimts, if scalar, constant gap
%  bitwid : bit-width used while normalizing
%  varargin : the inputs
%  y : the outputs
%     length(y) == length(varargin) + 1,
%       with y{end} being the data-valid pulse
%
%       varargin{1} is the referential data
% byHqz @20200215, version 1.0
% 

if nargin < 4
    res = 0;
    return;
end

Nrow = length(varargin{1});
if length(gap) == 1
    indx_gap = ones(Nrow,1)*gap;
else
    indx_gap = randi(gap,Nrow,1);
end
indx = cumsum([1;indx_gap]);

Ncol = length(varargin)+1; % the last col is data-valid flag
Nrow = indx(end) - 1;

% y{1} is date-valid pulse
y = zeros(Nrow,Ncol);
y(indx(1:end-1),Ncol) = 1;

% y{2:end} is date, with data hold
for ii = 1:length(varargin)
    if length( varargin{ii} ) == 1
        y(:,ii) = varargin{ii};
    else
        for jj = 1 : length(indx)-1
            y(indx(jj):indx(jj+1)-1,ii) = ...
                round( varargin{ii}(jj) * 2^bitwid );
        end
    end
end

% write_datafile(fn, reshape(y.',[],1) );
write_datafile(fn, y);
res = 1;

end

