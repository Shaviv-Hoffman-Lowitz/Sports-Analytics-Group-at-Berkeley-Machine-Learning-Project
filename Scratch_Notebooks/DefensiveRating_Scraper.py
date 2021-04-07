#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
from bs4 import BeautifulSoup
from urllib.request import urlopen, Request
import requests


# In[2]:


res = requests.get('https://hashtagbasketball.com/nba-defense-vs-position')
soup = BeautifulSoup(res.text, 'lxml')
pg, sg, sf, pf, c = [], [], [], [], []
table = soup.find('table', attrs={'id':'ContentPlaceHolder1_GridView1'})
for tr in table.find_all('tr'):
    td_list = tr.find_all('td')
    if tr.find('td') is not None:
        text = " ".join([i for i in td_list[1].text.split() if not i.isdigit()])
        if td_list[0].text == 'PG':
            pg.append(text)
        elif td_list[0].text == 'SG':
            sg.append(text)
        elif td_list[0].text == 'SF':
            sf.append(text)
        elif td_list[0].text == 'PF':
            pf.append(text)
        elif td_list[0].text == 'C':
            c.append(text)


# In[3]:


rank = list(range(1, 31))
columns = ['Team', 'vs PG', 'vs SG', 'vs SF', 'vs PF', 'vs C']
df_pg = pd.DataFrame({'Team':pg, 'vs PG':rank}).sort_values('Team')
df_sg = pd.DataFrame({'Team':sg, 'vs SG':rank}).sort_values('Team')
df_sf = pd.DataFrame({'Team':sf, 'vs SF':rank}).sort_values('Team')
df_pf = pd.DataFrame({'Team':pf, 'vs PF':rank}).sort_values('Team')
df_c = pd.DataFrame({'Team':c, 'vs C':rank}).sort_values('Team')
a = pd.merge(df_pg, df_sg, on='Team')
b = pd.merge(a, df_sf, on='Team')
c = pd.merge(b, df_pf, on='Team')
d = pd.merge(c, df_c, on='Team')


# In[4]:


df = d.reindex(columns=columns)
df.to_csv('OutputCSVs/team_def_vs_position.csv', header=True, index=False)


# In[5]:


df


# In[6]:


import datetime
now = datetime.datetime.now()
print (now.strftime("%Y-%m-%d %H:%M:%S"))

