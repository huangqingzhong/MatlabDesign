function varargout = gen_hdl_test_data( gap, bitwid, varargin )
%GEN_HDL_TEST_DATA generate HDL-testing data
%  gap : the gaps limimts, if scalar, constant gap
%  bitwid : bit-width used while normalizing
%  varargin : the inputs
%  varargout : the outputs
%     length(varargout) == length(varargin) + 1,
%       with varargout{end} being the data-valid pulse
%
%       varargin{1} is the referential data
% byHqz @20200215, version 1.0
%

if nargin < 3
    varargout = [];
    return;
end
Nrow = length(varargin{1});
if length(gap) == 1
    indx_gap = ones(Nrow,1)*gap;
else
    indx_gap = randi(gap,Nrow,1);
end
indx = cumsum([1;indx_gap]);

Ntot = indx(end);

% varargout{1} is date-valid pulse
varargout = cell(1,length(varargin)+1);
varargout{length(varargin)+1} = zeros(Ntot-1,1); 
varargout{length(varargin)+1}(indx(1:end-1)) = 1;

% varargout{2:end} is date, with data hold
for ii = 1:length(varargin)
    if length( varargin{ii} ) == 1
        varargout{ii} = ones(Ntot-1,1) * varargin{ii};
    else
        varargout{ii} = zeros(Ntot-1,1);
        for jj = 1 : length(indx)-1
            varargout{ii}(indx(jj):indx(jj+1)-1) = ...
                round( varargin{ii}(jj) * 2^bitwid );
        end
    end
end

end

