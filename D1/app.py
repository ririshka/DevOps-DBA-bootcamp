from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/check', methods=['GET', 'POST'])
def check_even_odd():
    if request.method == 'POST':
        data = request.get_json()
        number = data.get('number', None)
    else:
        number = request.args.get('number', type=int)

    if number is None:
        return jsonify({"error": "Please provide a number."}), 400
    
    if number % 2 == 0:
        result = "even"
    else:
        result = "odd"
    
    return jsonify({"number": number, "result": result})

if __name__ == '__main__':
    app.run(debug=True)
