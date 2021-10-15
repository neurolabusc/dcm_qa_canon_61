## About

`dcm_qa_canon_61` is a simple DICOM to NIfTI validator script and dataset. This repository is similar to [https://github.com/neurolabusc/dcm_qa_canon](https://github.com/neurolabusc/https://github.com/neurolabusc/dcm_qa_canon), but includes both DICOM images from a Canon 3T Galan MRI scanner using software V6.1SP3002 rather than V6.0SP2000. Specifically, the same data was exported as both enhanced and classic DICOM data.


## Details

The images were acquired on a Canon Galan 3T by Clément Debacker at Le Groupe Hospitalier Universitaire Paris. Data was saved as both classic (where each slice is a separate file) as well as enhanced DICOM (where an entire series of images is saved as a single file) format.

* Common Parameters 
  * Manufacturer: Canon
  * Model: Galan 3T",
  * Software Versions: V6.1SP3002*

| Series | Sequence name      | Comments                                       |
| ------ | ------------------ | ---------------------------------------------- |
| 3000   | DTI_PA-ortho       | Axial strict, P→A                              |
| 4000   | DTI_AP-ortho       | Axial strict, A→P                              |
| 5000   | DTI_PA-SAG_20d     | Axial, P→A, on a sagittal view ~20° angulation |
| 6000   | DTI_PA-AX_20d      | Axial, P→A, on an axial view ~20° angulation   |
| 7000   | DTI_PA-COR_20d     | Axial, P→A, on an coronal view ~20° angulation |
| 8000   | DTI_PA-ALL_20d     | Axial, P→A, on all view ~20° angulation        |
| 9000   | SAG_DTI_PA-ortho   | Sagittal strict, P→A                           |
| 10000  | SAG_DTI_PA-COR_20d | Sagittal strict, P→A, on an coronal view ~20°  |
| 11000  | SAG_DTI_PA-ALL_20d | Sagittal strict, P→A, on all view ~20°         |
| 14000  | DTI_PA-ortho-HT    | Axial strict, P→A, head turned ~20°            |
| 15000  | DTI_PA-ortho-HT-VT | Axial, P→A, head and angulation of ~20°        |

## Running

Assuming that the executable dcm2niix is in your path, you should be able to simply run the script `batch.sh` from the terminal.

## Links

 - [dcm_qa_canon_enh](https://github.com/neurolabusc/dcm_qa_canon_enh) enhanced DICOMs from V6.0SP2000.
 - [dcm_qa_canon](https://github.com/neurolabusc/dcm_qa_canon) classic DICOMs from from V6.0SP2000.
 - [dcm_qa_toshiba](https://github.com/neurolabusc/dcm_qa_toshiba) classic DICOMs from from V5.0SP6000
