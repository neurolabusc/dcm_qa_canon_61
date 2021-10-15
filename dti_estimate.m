function dti_estimate
pth = fullfile(pwd, 'Out');
if ~exist(pth,'Dir'), error('Unable to find %s', pth); end
d = dir(fullfile(pth,'*.bvec'));
if isempty(d), error('No bvec files found in %s', pth); end
fnms = {d(:).name}';
for i = 1 : numel(d)
    fnm = fullfile(pth, fnms{i});
    if ~exist(fnm, 'File'), error('Unable to find %s\n', fnm); end
    fprintf('%s\n',fnm)
    dtiSub(fnm);
end

%loca functions follow

function maskNam = betSub(fsldir,imgNam, refVol) %brain extract
setenv('FSLDIR', fsldir);
[pth,nam,ext] = fileparts(imgNam);
if strcmpi(ext,'.gz'), [~,nam] = fileparts(nam); end;
inNam = imgNam;
maskNam = fullfile(pth, nam ); %will generate image "dti_mask.nii.gz"
if (exist('refVol','var')) && (refVol > 0)
    %fslroi WIPDiffHR2.2SENSE4.2_ID123_12 msk 32 1
    refNam = fullfile(pth, [nam '_' num2str(refVol)] ); %will generate image "dti_mask.nii.gz"
    command=sprintf('sh -c ". ${FSLDIR}/etc/fslconf/fsl.sh; ${FSLDIR}/bin/fslroi %s %s %d 1"\n',imgNam,refNam, refVol);
    system(command);
    inNam = refNam;
end
command=sprintf('sh -c ". ${FSLDIR}/etc/fslconf/fsl.sh; ${FSLDIR}/bin/bet %s %s -f 0.3 -g 0 -n -m"\n',inNam,maskNam);
maskNam = fullfile(pth, [nam '_mask.nii.gz']); %will generate image "dti_mask.nii.gz"
system(command);
fprintf(command);
%end betSub()

function dtiSub(vNam) %compute vectors
%%/usr/local/fsl/bin/dtifit --data=/Users/rorden/Desktop/sliceOrder/dicom2/dtitest/dti_eddy.nii.gz --out=/Users/rorden/Desktop/sliceOrder/dicom2/dtitest/dti --mask=/Users/rorden/Desktop/sliceOrder/dicom2/dtitest/dti_mask.nii.gz --bvecs=/Users/rorden/Desktop/sliceOrder/dicom2/dtitest/s004a001.bvec --bvals=/Users/rorden/Desktop/sliceOrder/dicom2/dtitest/s003a001.bval
fsldir = fullfile(getenv('HOME'),'fsl');
if ~exist(fsldir,'dir'), fsldir= '/usr/local/fsl'; end
refVol = 1;
if ~exist(fsldir,'dir'), error('Unable to find %s', fsldir); end
[pth,nam,ext] = fileparts(vNam);
bNam = fullfile(pth, [ nam '.bval'] );
if ~exist(bNam, 'File'), error('Unable to find %s', bNam); end
imgNam = fullfile(pth, [ nam '.nii'] );
if ~exist(imgNam, 'File'), error('Unable to find %s', imgNam); end
maskNam = betSub(fsldir,imgNam, refVol);
if ~exist(maskNam, 'file'), error('BET failed to create %s', maskNam); end
eccNam = imgNam;
[pth,nam,ext] = fileparts(vNam);
outNam = fullfile(pth, nam); %Eddy corrected data
setenv('FSLDIR', fsldir);
setenv('PATH', [getenv('PATH') ':/usr/local/fsl/bin'])
command=sprintf('sh -c ". ${FSLDIR}/etc/fslconf/fsl.sh; ${FSLDIR}/bin/dtifit --save_tensor --data=%s --out=%s --mask=%s --bvecs=%s --bvals=%s"\n',eccNam, outNam, maskNam,vNam,bNam);
system(command);
fprintf(command);
delete(fullfile(pth, [nam '_V2.nii.gz']));
delete(fullfile(pth, [nam '_V3.nii.gz']));
delete(fullfile(pth, [nam '_L1.nii.gz']));
delete(fullfile(pth, [nam '_L2.nii.gz']));
delete(fullfile(pth, [nam '_L3.nii.gz']));
delete(fullfile(pth, [nam '_MO.nii.gz']));
%delete(fullfile(pth, [nam '_MD.nii.gz']));
delete(fullfile(pth, [nam '_S0.nii.gz']));
%end dtiSub