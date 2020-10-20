from flask import Flask, request, jsonify

import recommend, sql,getNaver

app = Flask(__name__)

member = {}
lst = []
li = []


# @app.route('/recommendUser.mo', methods=['post'])
@app.route('/recommendUser/<nick>')
def recommendUser(nick):
    member, lst = sql.getMember()
    li = recommend.top_match(member, nick)
    print(li)
    return jsonify(li)


@app.route('/expectedGrade/<nick>')
def expectedGrade(nick):
    member, lst = sql.getMember()
    li = recommend.getRecommendation(member, nick)
    print(li)
    return jsonify(li)

@app.route('/getNaverRanking/')
def getNaverRanking():
    li = getNaver.getNaver();
    return jsonify(li)

if __name__ == "__main__":
    app.run()
