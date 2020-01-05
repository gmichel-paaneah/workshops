# Call this function with a list of student emails

def strip_emails(email_list):
    import json
    new_list = []
    for email in email_list:
        formatted = email.split('@')[0]
        new_list.append(formatted)
    final = json.dumps(new_list)
    print(final)