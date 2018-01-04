#! /usr/bin/python3

"""
Create Jekyll redirects

Given a list of redirects to create, this script will create the necessary
HTML files to "redirect" URL paths in a Jekyll site to other URLs.

First create a YAML file at the root of your site called
"redirect-to-create.yaml", mapping local paths to redirect URLs - e.g.:

    "/posts/google": "https://www.google.com",
    "/about.html": "/about-me",
    "/posts/": "https://example.com/posts/"

Place this script next to that file at the root of your site directory
and run it.
"""

import argparse
import glob
import os
import yaml


# Read arguments
parser = argparse.ArgumentParser(
    description=(
        'Generate "redirect" HTML documents for a Jekyll site '
        'to forward certain URLs to new URLs. '
    )
)
parser.add_argument(
    '-f', '--force',
    help='Replace existing files and delete existing posts without asking',
    action="store_true"
)
parser.add_argument(
    'redirects_yaml',
    help='Path to a file mapping paths to destination URLs in YAML format'
)
cli_arguments = vars(parser.parse_args())

with open(cli_arguments['redirects_yaml']) as redirects_file:
    redirects = yaml.load(redirects_file)

for path, url in redirects.items():
    redirect_contents = (
        '<link rel="canonical" href="{url}">'
        '<meta http-equiv="refresh" content="0; url={url}">'
    ).format(url=url)

    clean_path = path.strip('/').rstrip('.html')

    file_doc = clean_path + '.html'
    directory_doc = clean_path + '/index.html'
    posts = glob.glob('_posts/*' + os.path.basename(clean_path) + '.*')
    # if "docker" in path:
    #     import ipdb; ipdb.set_trace()
    confirms = []

    if os.path.isfile(file_doc):
        with open(file_doc) as redirect_file:
            if redirect_file.read() != redirect_contents:
                confirms.append("  - Replace {}".format(file_doc))

    if os.path.isfile(directory_doc):
        with open(directory_doc) as redirect_file:
            if redirect_file.read() != redirect_contents:
                confirms.append("  - Replace {}".format(directory_doc))

    if posts:
        message = "  - Delete:"

        for post in posts:
            message += "\n>   - {}".format(post)

        confirms.append(message)

    if not cli_arguments['force'] and confirms:
        question = "  To redirect {} we will:\n".format(clean_path)
        question += "\n".join(confirms)
        question += "\n  Is that okay? (y/N) "

        if not input(question).lower() == 'y':
            continue

    # Create the directory structure if it doesn't exist
    os.makedirs(clean_path, exist_ok=True)

    with open(file_doc, 'w') as file_redirect:
        file_redirect.write(redirect_contents)

    # Add "redirect" file for file URL (without slash)
    with open(directory_doc, 'w') as file_redirect:
        file_redirect.write(redirect_contents)

    # Delete any posts that might conflict
    for post in posts:
        os.remove(post)

    print('* Created redirect from {path} to {url}'.format(**locals()))
