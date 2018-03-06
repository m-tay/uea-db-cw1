from flask import Flask, render_template, request
import psycopg2

app = Flask(__name__)


def dbconnect():
    try:
        conn = psycopg2.connect("dbname=studentdb user=student host=127.0.0.1 password=dbpassword")
        return conn
    except Exception as e:
        print("Error connecting to database")


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/addCustomer', methods=['POST'])
def addcustomer():
    try:
        # clear connection in case of previous issues
        conn = None

        # get all form values for query
        customerID = int(request.form['customerID'])
        customerName = request.form['customerName']
        customerEmail = request.form['customerEmail']

        # connect to db, get cursor
        conn = dbconnect()
        cur = conn.cursor()

        # execute task 1 query
        cur.execute('INSERT INTO Customer VALUES (%s, %s, %s)', \
        [customerID, customerName, customerEmail])
        conn.commit()

        return render_template('index.html', msg1='Successfully added customer')

    except Exception as e:
        return render_template('index.html', msg1='Error adding customer', error1=e)

    finally:
        if conn:
            conn.close()


@app.route('/addTicket', methods = ['POST'])
def addticket():
    try:
        # clear connection in case of previous issues
        conn = None

        # get all form values for query
        ticketID = int(request.form['ticketID'])
        problem = request.form['problem']
        status = request.form['status']
        priority = int(request.form['priority'])
        customerID = request.form['customerID']
        productID = request.form['productID']

        # connect to db, get cursor
        conn = dbconnect()
        cur = conn.cursor()

        # execute task 2 query
        cur.execute('INSERT INTO  Ticket VALUES (%s, %s, %s, %s, CURRENT_TIMESTAMP, %s, %s)', \
        [ticketID, problem, status, priority, customerID, productID])
        conn.commit()

        return render_template('index.html', msg2='Successfully added ticket')

    except Exception as e:
        return render_template('index.html', msg2='Error adding ticket', error2=e)

    finally:
        if conn:
            conn.close()


if __name__ == '__main__':
    app.run()
