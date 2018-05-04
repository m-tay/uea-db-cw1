from flask import Flask, render_template, request
import psycopg2, psycopg2.extras

app = Flask(__name__)


def dbconnect():
    # clear conn in case of previous issues
    conn = None

    try:
        conn = psycopg2.connect("dbname=studentdb user=student host=127.0.0.1 password=dbpassword")

        return conn
    except Exception as e:
        print("Error connecting to database:" + e)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/addCustomer', methods=['POST'])
def addcustomer():
    try:
        # get all form values for query
        customerID = int(request.form['customerID'])
        customerName = request.form['customerName']
        customerEmail = request.form['customerEmail']

        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET SEARCH_PATH to supportdb')

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


@app.route('/addTicket', methods=['POST'])
def addticket():
    try:
        # get all form values for query
        ticketID = int(request.form['ticketID'])
        problem = request.form['problem']
        status = request.form['status']
        priority = int(request.form['priority'])
        customerID = request.form['customerID']
        productID = request.form['productID']

        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET SEARCH_PATH to supportdb')

        # execute task 2 query
        cur.execute('INSERT INTO Ticket VALUES (%s, %s, %s, %s, CURRENT_TIMESTAMP, %s, %s)', \
                    [ticketID, problem, status, priority, customerID, productID])
        conn.commit()

        return render_template('index.html', msg2='Successfully added ticket')

    except Exception as e:
        return render_template('index.html', msg2='Error adding ticket', error2=e)

    finally:
        if conn:
            conn.close()


@app.route('/addUpdate', methods=['POST'])
def addupdate():
    try:
        # get all form values for query
        ticketUpdateID = int(request.form['ticketupdateID'])
        message = request.form['message']
        ticketID = int(request.form['ticketID'])
        staffID = int(request.form['staffID'])

        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET SEARCH_PATH to supportdb')

        # execute task 3 query
        cur.execute('INSERT INTO TicketUpdate VALUES(%s, %s, CURRENT_TIMESTAMP, %s, %s)', \
                    [ticketUpdateID, message, ticketID, staffID])
        conn.commit()

        return render_template('index.html', msg3='Successfully added ticket')

    except Exception as e:
        return render_template('index.html', msg3='Error adding ticket', error3=e)

    finally:
        if conn:
            conn.close()


@app.route('/openTickets', methods=['GET'])
def opentickets():
    try:
        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET search_path to supportdb')


        # execute task 4 query
        cur.execute("SELECT * FROM opentickets")
        querydata = cur.fetchall()

        if querydata:
            return render_template('opentickets.html', rows=querydata)
        else:
            return render_template('index.html', msg4='No data found')

    except Exception as e:
        return render_template('index.html', msg4='Error loading open tickets', error4=e)

    finally:
        if conn:
            conn.close()


@app.route('/closeTicket', methods=['POST'])
def closeticket():
    try:
        # get all form values for query
        ticketID = int(request.form['ticketID'])

        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET SEARCH_PATH to supportdb')

        # check if ticket currently closed
        cur.execute("SELECT Status FROM Ticket WHERE TicketID = %s", [ticketID])
        currentstatus = cur.fetchone()

        if currentstatus is None:
            currentstatus = 'nothing found'

        if currentstatus[0] == 'closed':
            return render_template('index.html', msg5='Error: ticket already closed')

        else:
            # execute task 5 query
            cur.execute("UPDATE Ticket SET Status = 'closed' WHERE TicketID = %s", \
                        [ticketID])

            # get number of rows affected in cursor, to check for problems later
            rowsaffected = cur.rowcount
            conn.commit()

            if rowsaffected == 0:
                return render_template('index.html', msg5='Error: no ticket found')
            else:
                return render_template('index.html', msg5='Successfully closed ticket')

    except Exception as e:
        return render_template('index.html', msg5='Error closing ticket', error5=e)

    finally:
        if conn:
            conn.close()


@app.route('/listDetails', methods=['POST'])
def listdetails():
    try:
        # get ticketID value for query
        ticketID = int(request.form['ticketID'])


        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET SEARCH_PATH to supportdb')

        # execute task 6 queries
        # get problem statement
        cur.execute("SELECT problem FROM Ticket WHERE TicketID = %s", [ticketID])
        problem = cur.fetchone()

        # get ticketupdates
        cur.execute("SELECT TicketUpdate.Message, TicketUpdate.UpdateTime, \
                     COALESCE(Staff.Name, Customer.Name) As AuthoredBy FROM TicketUpdate \
                     LEFT JOIN Staff ON Staff.StaffID = TicketUpdate.StaffID, Customer, Ticket \
                     WHERE TicketUpdate.TicketID = Ticket.TicketID AND Ticket.CustomerID = Customer.CustomerID \
                     AND Ticket.TicketID = %s ORDER BY TicketUpdate.UpdateTime", [ticketID])
        querydata = cur.fetchall()


        if problem:
            return render_template('listdetails.html', problem=problem[0], rows=querydata)
        else:
            return render_template('index.html', msg6='No data found')

    except Exception as e:
        return render_template('index.html', msg6='Error listing details', error6=e)

    finally:
        if conn:
            conn.close()


@app.route('/closedStatus', methods=['GET'])
def closedstatus():
    try:
        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET SEARCH_PATH to supportdb')

        # execute task 7 query
        cur.execute("SELECT * FROM closedstatus")

        querydata = cur.fetchall()

        if querydata:
            return render_template('closedtickets.html', rows=querydata)
        else:
            return render_template('index.html', msg7='No data found')

    except Exception as e:
        return render_template('index.html', msg7='Error listing details', error7=e)

    finally:
        if conn:
            conn.close()


@app.route('/deleteCustomer', methods=['POST'])
def deletecustomer():
    try:
        # get all form values for query
        customerID = int(request.form['customerID'])

        # connect to db, get cursor, set schema
        conn = dbconnect()
        cur = conn.cursor()
        cur.execute('SET SEARCH_PATH to supportdb')

        # execute task 5 query
        cur.execute("DELETE FROM Customer WHERE CustomerID = %s", [customerID])
        conn.commit()

        return render_template('index.html', msg8='Successfully deleted customer')

    except Exception as e:
        return render_template('index.html', msg8='Error deleting customer', error8=e)

    finally:
        if conn:
            conn.close()

if __name__ == '__main__':
    app.run(debug=True)