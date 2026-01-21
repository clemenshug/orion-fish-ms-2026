------------------ 
TABLE OF CONTENTS
------------------

* GENERAL INFORMATION
  * TITLE
  * AUTHORS AND BEST CONTACT
  * RECOMMENDED CITATION
  * LICENSES
  * USEFUL LINKS
* DATE OF DATA COLLECTION
* FILE ORGANIZATION
* FUNDING
* ADDITIONAL NOTES/COMMENTS

**Note:** *If you are viewing on Zenodo, please check the GitHub link <insert link> for updates to this file.*

--------------------
GENERAL INFORMATION
--------------------

1. **Publication or Dataset Title:**  

2. **Authors:**

3. **Contact Information**  <who should be contacted about this data>
* Name: <FName LName>
* Organization/institution: <Contact person affiliation>
* Email: <institutional email address>

4. **Links to publications that cite or use the data:** 
<include DOI and APA citation to publications that use this data, if applicable>

5. **Recommended citation for this dataset:**  
<Following standard APA citation format>  
<Author Last, Author F. (Year). Title of data set (Version number) [Description of form]. Location: Name of producer.> 

6. **Licenses/restrictions placed on the data:** 
<e.g. CC BY https://creativecommons.org/licenses/by/4.0/>
  
7. **For more information, go to:** <Insert links where applicable to tissue-atlas.org or other landing page>

-------------------
FILE ORGANIZATION
------------------

1. **FILE NAMING CONVENTIONS:**   
Each file follows the following naming convention:  

2. **FILE TYPES/SUMMARY:**
Each folder corresponds to a patient sample (N). The following files are available for each patient and are located on [Synapse/AWS/Etc].

 <Data should be uploaded to the appropriate public repository where applicable>
 <DATA SHOULD NOT BE STORED ON GITHUB>
 <If you are not sure which repository to use for your data type reach out to your Data Managers>
 
|File Type     | Description                                                                        | Location|
|--------      | ----------------------------------------------------------------------------------|---------|
|N.ome.tif	   | Stitched multiplex CyCIF image pyramid in ome.tif format                           | AWS     |
|N_HE.vsi	     | Hematoxylin and Eosin stained image of adjacent FFPE tissue section in .vsi format | AWS     |
|\_N\_HE\_/    | folder: raw image data accompanying .vsi file                                      | AWS     |
|markers.csv   | list of all markers in ome.tif image                                               | [Synapse](https://www.synapse.org/)|
|N.csv         | single-cell feature table, including intensity data for all channels               | Synapse |
|N_ROI.csv     | X and Y coordinates for histologically annotated regions in CyCIF and H&E images   | Synapse |
|raw/          | folder of raw IF image data in .rcpnl format                                       | AWS     |
|segmentation/ |  folder of segmentation maps for tissue image in .tif format                       | AWS     |
| | Sequencing data | GEO|

 **Synapse Library:** [Edit this to link directly to your public Synapse Library](https://www.synapse.org/)  
  >*Free account registration is required to download files from Synapse.*  
 
 **AWS Data Access**
 >*Visit the following Zenodo page for instructions on how to access primary image data associated with this publication: Access Laboratory of Systems Pharmacology Datasets on AWS, DOI: [10.5281/zenodo.10223573](www.doi.org/10.5281/zenodo.10223573)*

 >***AWS Bucket:*** *You will need the following AWS bucket name to access data on AWS: <ADD AWS BUCKET NAME>*   

3. **FILE LIST** <*list all files (or folders, as appropriate for dataset organization) contained in the Synapse repository, with a brief description*>

**N.ome.tif**

|Patient | File Name       | Location| File size |
|------- | ----------------|---------|-----------|
|ID | ID.ome.tif | AWS     |    |


**N_HE.vsi**

|Patient | File Name      | Location| File size|
|--------| ---------------|---------|----------|
|ID | ID.ome.tif_HE.vsi | AWS     |  |


**\_N\_HE\_/**

|Patient | File Name   | Location| File size|
|------- | ------------|---------|----------|
|ID | frame_t.ets | AWS     |  |

**markers.csv**

|Patient | File Name   | Synapse ID  | File size|
|------- | ----------- |------------ |----------|
|ID | markers.csv | syn12345678 | |

**N.csv**

|Patient | File Name   | Synapse ID | File size |
|------- | ------------|------------|-----------|
|ID | ID.csv |  |  |

**N_ROI.csv**

|Patient | File Name       | Synapse ID  | File size|
|------- | ----------------|-------------|----------|
|ID | ID_ROI.csv |  |    |

**raw/**

|Patient | Number of Files | Folder size| Location|
|------- |-----------------|------------|---------|
|ID | 13              |     |      |


**segmentation/**

|Patient | Number of Files | Folder size| Location|
|------- |-----------------|------------|---------|
|ID |               |     |      |
 
 --------------------------
ADDITIONAL NOTES/COMMENTS
--------------------------

Please let **(Name, contact information)** know if any errors are found in this data.  
