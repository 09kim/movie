import pymysql


def getMember():
    conn = pymysql.connect(host='localhost', user='root', password='1234',
                           db='got', charset='utf8')
    curs = conn.cursor(pymysql.cursors.DictCursor)

    curs.execute('SELECT * from member')
    row = curs.fetchall()
    member = {}
    lst = []
    for i in row:
        sql = "SELECT * from grade where nick =%s"
        curs.execute(sql, i['nick'])
        row2 = curs.fetchall()
        member[i['nick']] = {}
        lst.append(i['nick'])

        for o in row2:
            member[i['nick']].update({o['title'] + "/" + str(o['movieSeq']): o['grade']})


    return member, lst
