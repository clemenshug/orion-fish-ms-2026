---
layout: default
title: Example data
nav_order: 20
nav_exclude: false
---
[//]: # You can hide this page if you don't need it! (nav_exclude: true)

# Example Data Set
[//]: # You may want to provide an example data set for your users. If this is for the tutorial, you may prefer to embed the information for accessing the data set directly in the tutorial page. 
[//]: # If the data set is more extensive (for example, a comprehensive list of the data used in your manuscript), you may prefer that it has it's own page. 
[//]: # For image data, you may want to embed some example images of the data set

*Four examples of different methods for embedding images:*

## 1. Image with a static width (defined by the page width)
![Image of exemplar data 2, showing four cores from a tissue microarray, stained with CD163, CD3D, CD31, VDAC1, and Keratin]({{ site.baseurl }}/images/mcmicro-exemplar-002.jpg)

```
![Image of exemplar data 2, showing four cores from a tissue microarray, stained with CD163, CD3D, CD31, VDAC1, and Keratin]({{ site.baseurl }}/images/mcmicro-exemplar-002.jpg)
```

## 2. Image with dynamic scaling (user defines image proportions with [basic grid](https://labsyspharm.github.io/just-the-docs-lsp/docs/utilities/layout/#image-cards){:target="_blank"}

[//]: # The basic grid has a max width of 12. Here, I've set my image to be smaller (1/3 of max) on a phone screen, and larger (1/2 of max) on a larger screen

<div class="row">

<div class="col-xs-4 col-sm-6">
<div markdown="1">
![Image of exemplar data 2, showing four cores from a tissue microarray, stained with CD163, CD3D, CD31, VDAC1, and Keratin]({{ site.baseurl }}/images/mcmicro-exemplar-002.jpg)
</div>
</div>

</div><!-- end grid -->


```
<div class="row">

<div class="col-xs-4 col-sm-6">
<div markdown="1">
![Image of exemplar data 2, showing four cores from a tissue microarray, stained with CD163, CD3D, CD31, VDAC1, and Keratin]({{ site.baseurl }}/images/mcmicro-exemplar-002.jpg)
</div>
</div>

</div><!-- end grid -->
```



## 3. Image with a static width (defined by the user) 
<br>

{: .text-center }
{: .fs-3 }
{: .fw-300 }
<figure>
	<a>
		<img src="{{ site.baseurl }}/images/mcmicro-exemplar-002.jpg" style="max-width: 300px;"
			 alt="Image of exemplar data 2, showing four cores from a tissue microarray, stained with CD163, CD3D, CD31, VDAC1, and Keratin)"  />
	</a> <figcaption>MCMICRO exemplar-002, showing four cores from a tissue microarray.</figcaption> 
</figure>

```
{: .text-center }
{: .fs-3 }
{: .fw-300 }
<figure>
	<a>
		<img src="{{ site.baseurl }}/images/mcmicro-exemplar-002.jpg" style="max-width: 300px;"
			 alt="Image of exemplar data 2, showing four cores from a tissue microarray, stained with CD163, CD3D, CD31, VDAC1, and Keratin)"  />
	</a> <figcaption>MCMICRO exemplar-002, showing four cores from a tissue microarray.</figcaption> 
</figure>
```
<br>

You can add a hyperlink to this image with the following addition:
```
{: .text-center }
{: .fs-3 }
{: .fw-300 }
<figure>
	<a href="https://mcmicro.org/datasets/">
		<img src="{{ site.baseurl }}/images/mcmicro-exemplar-002.jpg" style="max-width: 300px;"
			 alt="Image of exemplar data 2, showing four cores from a tissue microarray, stained with CD163, CD3D, CD31, VDAC1, and Keratin)"  />
	</a> <figcaption>MCMICRO exemplar-002, showing four cores from a tissue microarray.</figcaption> 
</figure>
```


## 4. Image card with link
**This method is often used for Minerva stories**

{% assign imageUrl = site.baseurl | append: "/images/mcmicro-exemplar-002.jpg" %}{% include image-card.html 
    image=imageUrl
    link="https://mcmicro.org/datasets/"
    label="Label for image"
	%}

```
{% assign imageUrl = site.baseurl | append: "/images/mcmicro-exemplar-002.jpg" %}{% include image-card.html 
    image=imageUrl
    link="https://mcmicro.org/datasets/"
    label="Label for image"
	%}
```
	