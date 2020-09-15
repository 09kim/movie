#sub_pack > div.z_aside.section.rktshp

import requests
from bs4 import BeautifulSoup
import re as r


# r=requests.get("https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EC%98%81%ED%99%94&oquery=%EC%8B%A4%EC%8B%9C%EA%B0%84%EA%B2%80%EC%83%89%EC%96%B4&tqi=U1cj1lp0YihssZ8hch0sssssspw-184247").text
# soup=BeautifulSoup(r,'lxml');
# # rank = soup.find_all(attrs={'class':'>tit'})
# rank = soup.select('#sub_pack > div.z_aside.section.rktshp > div.realtime_srch > ol > li > a > span')
#
# for i in rank:
#     print(i.text)
def getNaver():
    list = [];
    r=requests.get("https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%ED%85%8C%EB%84%B7&oquery=%ED%98%84%EC%9E%AC%EC%83%81%EC%98%81%EC%9E%91&tqi=U19m5wp0Jywss6YjGvGssssstLo-473337").text;
    soup=BeautifulSoup(r,'lxml');
    rank = soup.select("#sub_pack > div.z_aside.section.rktshp > div.realtime_srch > ol > li > a");

    for i in rank :
        list.append(i.text)
    return list


