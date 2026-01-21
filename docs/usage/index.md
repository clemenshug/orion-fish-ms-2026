---
layout: page
title: Running MY SOFTWARE
nav_order: 6
has_children: true
---

# Running MY SOFTWARE
This page serves as a reference guide for MY SOFTWARE syntax - you must [install](installation.html) before proceeding. 

Refer to the [tutorial]({{ site.baseurl }}/tutorial.html) for an example step-by-step guide for how to use MY SOFTWARE.

## Description
[//]: # This should be a brief, 1-2 sentence description
**MY SOFTWARE** performs this task. 

## Input
[//]: # Describe the input
An ```.ome.tiff``` and `markers.csv` file

[//]: # For inputs that require specific formatting, you may want to use sub-headings to describe those input formats. For example, a .csv may require specific formatting for the software, or a ome.tiff may need to be pre-stitched, etc.
### Example markers file
The markers file should be formatted in this way


## Output
A pyramidal, tiled ```.ome.tif```

## Usage:
MY SOFTWARE can be run with the following command
```
MY-SOFTWARE FILE [FILE ...] [OPTIONS] 
```

[//]: # Add an example of how to call the software with a simple set of inputs
For example, to run MY SOFTWARE on a set of data stored at my/path, with OPTION-Y set to 30:
```
MY-SOFTWARE FILE my/path --OPTION-Y 30
```

## Required arguments
[//]: # Describe the required inputs, we've shown one as an example

| Name | Description |
|---|---|
| ```FILE``` | an `ome.tif` image file to be processed|

## Optional arguments
[//]: # Describe optional arguments and defaults. If the options need more description, add subheadings with additional information below the table (as shown with Option-y). 

|  Name; Shorthand | Description | Default|
|---|---|---|
|```--help; -h```| Show this help message and exit| |
|```--output DIR; -o DIR```|Write image files to DIR|Current directory|
|```--OPTION-Y```|Set the number to run with option y. [Read below](./#option-y) for more information about selecting a value for option y. | 5 |

### OPTION Y
The default value works well in many cases, but increasing the value will do X. If you notice Y in your output, the value may need to be adjusted. 

