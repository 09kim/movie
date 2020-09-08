from flask import Flask, request, jsonify
import recommend,sql

app = Flask(__name__)

member = {}
lst = []
li = []

# @app.route('/recommendUser.mo', methods=['post'])
@app.route('/recommendUser.mo/<nick>')
def recommendUser(nick):
    member, lst = sql.getMember(nick)
    lst = recommend.top_match(member,nick)
    return jsonify(lst)

@app.route('/expectedGrade.mo/<nick>')
def expectedGrade(nick):
    member, lst = sql.getMember(nick)
    li = recommend.getRecommendation(member,nick)
    return jsonify(li)


if __name__ == "__main__":
    app.run()
