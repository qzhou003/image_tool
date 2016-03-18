import os
import sys
import argparse
from selenium import webdriver
import requests
import platform


FLICKR_URL = 'https://www.flickr.com/search/?'
SEARCH_TEXT = 'text='
ONLY_PHOTOS = '&media=photos'


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', dest='text')
    parser.add_argument('-n', dest='screen_count')
    parser.add_argument('-p', dest='output_path')
    args = parser.parse_args()
    return args.text, args.screen_count, args.output_path


def get_url_by_css_value(css_val):
    """
    Removes 'url("' and '")' around url and yields it
    :param css_val: background-image css value
    :return: yields image url, str
    """
    if platform.system()=='Darwin':
        img_url = str(css_value).replace('url(', '').replace(')', '')
    else:
        img_url = str(css_value).replace('url("', '').replace('")', '')
    return img_url


def fetch_name_from_url(url):
    parts = url.split('/')
    return parts[-1]


def scroll_screen(browser, screen_count):
    """
    Scrolls down page for download more images

    :param browser: selenium webdriver object
    :param screen_count: how many times need to scroll down
    """
    for _ in screen_count:
        browser.execute_script(
            'window.scrollTo(0, document.body.scrollHeight);'
        )


if __name__ == '__main__':

    text, screen_count, output_path = get_args()
    if not text:
        sys.exit('search text required. Call download.py with -t text')
    if not screen_count:
        screen_count = 0
    if not output_path:
        sys.exit('output path required. Call download.py with -p your_path')

    # Create output directory if not exists
    if not os.path.exists(output_path):
        os.makedirs(output_path)

    #browser = webdriver.Firefox()
    browser = webdriver.Safari()
    # Building search url
    search_url = ''.join([FLICKR_URL, SEARCH_TEXT, text, ONLY_PHOTOS])
    browser.get(search_url)
    print ("search_url = %s" % search_url)
    browser.implicitly_wait(10)
    if screen_count:
        scroll_screen(browser, screen_count)

    img_divs = browser.find_elements_by_css_selector('.awake')

    # TODO: need to refactor this
    for div in img_divs:
        css_value = div.value_of_css_property('background-image')
        print ("css_value = %s" %css_value)
        print (platform.system())
        url = get_url_by_css_value(css_value)
        print ("url_before = %s"%url)
        name = fetch_name_from_url(url)
        print("url = %s"%url)
        r = requests.get(url)
        if r.status_code == 200:
            with open('{path}/{name}'.format(path=output_path,
                                             name=name), 'wb') as f:
                for chunk in r:
                    f.write(chunk)

    browser.close()
