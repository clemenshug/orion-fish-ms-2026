# Software Website Template

**Use this repo as a template to build your own software website.** 

- The template has suggested formatting, links, and content suggestions embedded within .md files. 
- Edit the suggested headings & content to fit your use-case. 
- Comments with instructions start with `[//]: # ` *comments will not appear on the website*

- You can hide pages that aren't relevant to your site by adding `nav_exclude: true` to the file header. 
- Internal links within the template should continue to work as long as you don't change the file names or page parent (`has_children: true`) children (`parent: parent page title`).

## Using the template

### 1. Copy the template into a new repo
- [Import**](https://github.com/new/import) "labsyspharm/blank-software-website" as a new repo. 
- Set the owner as labsyspharm\*
- Name the new repo with your website name

\* Please set labsyspharm as the owner to allow us to keep track of all LSP related research websites and maintain it beyond your tenure in the lab. 

\*\* *If you want to host the website files within the same repo as your software, you can alternatively copy all files contained within the template `docs/` folder into your software repo.*  

<br>

### 2. Edit files
**You can do this two ways - online through github.com or locally using terminal and a text editor.**

*The jekyll tutorial website includes some [Markdown basic syntax](https://labsyspharm.github.io/jekyll-tutorial/markdown-basic) to get you started, and we've included some [useful basics](https://github.com/labsyspharm/blank-software-website#useful-formatting-links) below.*
<br>

#### Option 1: Local editing

1. [Install Jekyll locally](https://jekyllrb.com/docs/installation/#requirements)
<br>
  
2. Clone the repo 
- This will insert blank-software-website files into your current directory
- You can find the https link for your new repo on the green 'code' button on the main repo page
```
$ git clone <https>
```
<br>

3. Navigate into the docs folder
```
$ cd your-website-name/docs/
```
<br>

4. Install the necessary gems
```
$ bundle install
```
<br>


5. Generate a local website to preview
```
$ bundle exec jekyll serve
```
*The site address will be visible in your terminal, probably http://localhost:4000/*

<br>

6. You can now make edits to the website files locally using your favorite text editor. 
<br>

#### Option 2: Online through GitHub
1. To edit an existing page, open the markdown file and start editing it by clicking the pencil icon in the top right tool bar. You can commit these changes directly to your repo. 
<br>

2. If you want to see the changes you've made, you can go ahead and [publish the website](https://github.com/labsyspharm/blank-software-website#4-publish-website). Changes will take a few minutes to appear on the website (and require a page refresh). 
<br>

### 3. Update `_config.yml` to make the website yours!
config.yml contains the overall formatting of the site. See the [Jekyyl Tutorial](https://labsyspharm.github.io/jekyll-tutorial/customizations/) for more information.

* Change the title - this will display as the name of your site 
* You must change all instances of 'blank-software-website' to the name of your current repo. 
* Ensure that you have made a license file for the software and add in the relevant path to this file.
* Update the path to your banner image and logo
* You may toggle the color theme if desired
<br>

### 4. Publish website!
- Go the the settings of your repo: https://github.com/.../repo-name/settings/pages
- Click 'pages' on the left hand menu
- Select the branch you want to publish, 'docs' as the source folder, and hit 'save'
- Your website url will display above (username.github.io/repo-name)
<br>

***(Optionally) If your publication involves releasing data or code, follow [these instructions](https://labsyspharm.github.io/jekyll-tutorial/website-template/#datarelease-readmemd-in-the-website-templates) to display data table at the bottom of your repository.*
<br>

## Useful formatting links

See the [Just the Docs - LSP](https://labsyspharm.github.io/just-the-docs-lsp/) page for complete and thorough information about how to edit the template format! 

### Open in a new tab
```
[Display text](URL){:target="_blank"}
```

### Add a button 
```
[Link button](http://example.com/){: .btn }
[Link button](http://example.com/){: .btn .btn-blue }
[Link button](http://example.com/){: .btn .btn-green }
[Link button](http://example.com/){: .btn .btn-outline }
[Link button](http://example.com/){: .btn .btn-outline .btn-arrow }
```
*Back to top buttons are very useful for long pages!

### Add Table of Contents

*Bulleted list*
```
<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
  - TOC
{:toc}
</details>
```

*Numbered list*
```
<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
  1. TOC
{:toc}
</details>
```

### Images

You'll find 4 examples of how to define images in the [example data set](https://github.com/labsyspharm/blank-software-website/blob/main/docs/dataset.md) page

### Line break
Use `<br>` to add extra spacing

### Make a table

```
| | | |
|---|---|---|
| | | |
| | | |
```

**For more tips to get started, visit the [Jekyll tutorial FAQ](https://labsyspharm.github.io/jekyll-tutorial/faq). Thorough documentation for editing the website theme can be accessed at [Just the Docs - LSP](https://labsyspharm.github.io/just-the-docs-lsp/).**


