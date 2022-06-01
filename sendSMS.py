import urllib
import json
import time
import random
#SenderSMS

from userDbConfig import UserInfo

errors = {
        1: 'Ошибка в параметрах.',
        2: 'Неверный логин или пароль.',
        3: 'Недостаточно средств на счете Клиента.',
        4: 'IP-адрес временно заблокирован из-за частых ошибок в запросах. Подробнее',
        5: 'Неверный формат даты.',
        6: 'Сообщение запрещено (по тексту или по имени отправителя).',
        7: 'Неверный формат номера телефона.',
        8: 'Сообщение на указанный номер не может быть доставлено.',
        9: 'Отправка более одного одинакового запроса на передачу SMS-сообщения либо более пяти одинаковых запросов на получение стоимости сообщения в течение минуты. '
    }

def send_sms(phones, text, total_price=0):
    login = 'userlog'  # Логин в smsc
    password = 'myPas1'  # Пароль в smsc
    sender = 'Python'  # Имя отправителя
    url = "http://smsc.ru/sys/send.php?login=%s&psw=%s&phones=%s&mes=%s&cost=%d&sender=%s&fmt=3" % (
    login, password, phones, text, total_price, sender)
    answer = json.loads(urllib.urlopen(url).read())
    if 'error_code' in answer:
        #Error
        return errors[answer['error_code']]
    else:
        if total_price == 1:
            #Price
            print('Будут отправлены: %d SMS, цена рассылки: %s' % (answer['cnt'], answer['cost'].encode('utf-8')))
        else:
            #Success
            return answer

def get_all_users_list():
    users = UserInfo.query.all()
    output = []
    for user in users:
        output.append({
            'userId': user.userId,
            'lastName': user.lastName,
            'firstName': user.firstName,
            'phoneNumber': user.phoneNumber,
            'email': user.email
        })
    return output

def my_sender():
    output = get_all_users_list()
    for user in output:
        msg = "Здравствуйте, " + user["firstName"] + "! Ваш код подтверждения для HealthyBet: " + random.randint(100000, 999999)
        send = send_sms(user['phoneNumber'], msg)
        if 'cnt' in send:
            print('На номер %s, сообщение отправлено успешно!', user['phoneNumber'])
            time.sleep(30)
        else:
            print("Не удалось отправить сообщение")