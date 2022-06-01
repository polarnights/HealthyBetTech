CREATE TABLE IF NOT EXISTS achieves_dict
(
    achieve_id       INTEGER,
    utc_created_dttm INTEGER,
    description      VARCHAR,
    achieve_type     VARCHAR,
    utc_updated_dttm VARCHAR
);

COMMENT ON TABLE achieves_dict IS '- Таблица с описанием ачивок';

COMMENT ON COLUMN achieves_dict.achieve_id IS '- Идентификатор ачивки';

COMMENT ON COLUMN achieves_dict.utc_created_dttm IS '- Дата создания ачивки (UTC)';

COMMENT ON COLUMN achieves_dict.description IS '- Описание ачивки';

COMMENT ON COLUMN achieves_dict.achieve_type IS '- Тип ачивки';

COMMENT ON COLUMN achieves_dict.utc_updated_dttm IS '-  Время изменения записи (UTC)';

CREATE TABLE IF NOT EXISTS device_dict
(
    device_id         INTEGER NOT NULL
        CONSTRAINT pk_device_dct
            PRIMARY KEY,
    device_model_name varchar(100),
    platform_name     varchar(100)
);

COMMENT ON TABLE device_dict IS '- Таблица с описанием устройств';

COMMENT ON COLUMN device_dict.device_id IS '- Идентификатор устройства';

COMMENT ON COLUMN device_dict.device_model_name IS '- Модель устройства';

COMMENT ON COLUMN device_dict.platform_name IS '- ОС устройства';

CREATE TABLE IF NOT EXISTS game_dict
(
    game_id             INTEGER
        CONSTRAINT unq_game_disct_game_id
            UNIQUE,
    utc_created_dttm    VARCHAR,
    "utc_updated_dttm " VARCHAR,
    description         VARCHAR
);

COMMENT ON TABLE game_dict IS '- Таблица с описанием игр';

COMMENT ON COLUMN game_dict.game_id IS '- Идентификатор игры';

COMMENT ON COLUMN game_dict.utc_created_dttm IS '- Время создания игры';

COMMENT ON COLUMN game_dict."utc_updated_dttm " IS '- Время изменения записи в таблице';

COMMENT ON COLUMN game_dict.description IS '- Описание игры';

CREATE TABLE IF NOT EXISTS purchase_dict
(
    "utc_created_dttm " VARCHAR,
    purchase_type       VARCHAR,
    purchase_id         INTEGER
        CONSTRAINT unq_purchase_dict_purchase_id
            UNIQUE,
    description         VARCHAR,
    purchase_cost       INTEGER,
    currency            VARCHAR,
    utc_updated_dttm    DATE
);

COMMENT ON TABLE purchase_dict IS '- Таблица с описанием товаров';

COMMENT ON COLUMN purchase_dict."utc_created_dttm " IS '- Время создания товара';

COMMENT ON COLUMN purchase_dict.purchase_type IS '- Тип товара (скин, ачивка и тд)';

COMMENT ON COLUMN purchase_dict.purchase_id IS '- Идентификатор товара';

COMMENT ON COLUMN purchase_dict.description IS '- Описание товара';

COMMENT ON COLUMN purchase_dict.purchase_cost IS '- Стоимость товара';

COMMENT ON COLUMN purchase_dict.currency IS '- Валюта стоимости товара';

COMMENT ON COLUMN purchase_dict.utc_updated_dttm IS '- Время обновления записи в таблице (UTC)';

CREATE TABLE IF NOT EXISTS subscription_dict
(
    subscription_id       INTEGER
        CONSTRAINT unq_subscription_type_dict_subscription_type_id
            UNIQUE,
    utc_created_dttm      INTEGER,
    duration_subscription DATE,
    subscription_cost     INTEGER,
    currency              VARCHAR,
    description           INTEGER,
    utc_updated_dttm      DATE
);

COMMENT ON TABLE subscription_dict IS '- Таблица с писанием  типов подписок';

COMMENT ON COLUMN subscription_dict.subscription_id IS '- Идентификатор типа подписки';

COMMENT ON COLUMN subscription_dict.utc_created_dttm IS '- Время создания этого типа подписки';

COMMENT ON COLUMN subscription_dict.duration_subscription IS '- Длительность подписки (мес)';

COMMENT ON COLUMN subscription_dict.subscription_cost IS '- Стоимость подписки';

COMMENT ON COLUMN subscription_dict.currency IS '- Валюта';

COMMENT ON COLUMN subscription_dict.description IS '- Кратклое описание';

COMMENT ON COLUMN subscription_dict.utc_updated_dttm IS '- Время обновления записи в таблице (UTC)';

CREATE TABLE IF NOT EXISTS user_profile
(
    user_id                     INTEGER NOT NULL
        CONSTRAINT pk_user_profile
            PRIMARY KEY,
    phone_number                VARCHAR,
    device_id                   INTEGER
        CONSTRAINT fk_user_profile_device_dict
            REFERENCES device_dict,
    email                       VARCHAR,
    utc_created_dttm            VARCHAR,
    utc_updated_dttm            VARCHAR,
    has_subscription            BOOLEAN,
    age                         INTEGER,
    weight                      INTEGER,
    gender                      VARCHAR,
    first_name                  VARCHAR,
    last_name                   VARCHAR,
    LOGIN                       VARCHAR,
    PASSWORD                    VARCHAR,
    LEVEL                       INTEGER,
    active_flg                  BOOLEAN,
    subsription_transaction_id  INTEGER,
    utc_subscription_start_dttm VARCHAR,
    utc_subscription_end_dttm   VARCHAR
);

COMMENT ON TABLE user_profile IS '- Таблица с описание профиля пользователя';

COMMENT ON COLUMN user_profile.user_id IS '- Идентификатор пользователя';

COMMENT ON COLUMN user_profile.phone_number IS '- Номер телефона';

COMMENT ON COLUMN user_profile.device_id IS '- Идентификатор устройства (появляется при каждой установке приложения)';

COMMENT ON COLUMN user_profile.email IS '- Почтовый адрес';

COMMENT ON COLUMN user_profile.utc_created_dttm IS '- Дата создания записи (UTC)';

COMMENT ON COLUMN user_profile.utc_updated_dttm IS '- Время изменения записи (UTC)';

COMMENT ON COLUMN user_profile.has_subscription IS '- Флаг наличия подписки';

COMMENT ON COLUMN user_profile.age IS '- Возраст';

COMMENT ON COLUMN user_profile.weight IS '-  Вес';

COMMENT ON COLUMN user_profile.gender IS '- Пол';

COMMENT ON COLUMN user_profile.first_name IS '- Имя';

COMMENT ON COLUMN user_profile.last_name IS '- Фамилия';

COMMENT ON COLUMN user_profile.LOGIN IS '- Логин';

COMMENT ON COLUMN user_profile.PASSWORD IS '- Пароль';

COMMENT ON COLUMN user_profile.LEVEL IS '- Уровень пользователя в игре';

COMMENT ON COLUMN user_profile.active_flg IS '- Флаг активного профиля пользователя (приложение не удалили)';

COMMENT ON COLUMN user_profile.subsription_transaction_id IS '- Идентификатор транзакции покупки  подписки, если она есть';

COMMENT ON COLUMN user_profile.utc_subscription_start_dttm IS '- Дата начала подписки (если она есть) (UTC)';

COMMENT ON COLUMN user_profile.utc_subscription_end_dttm IS 'Дата окончания действия подписки (если она есть) (UTC)';

CREATE TABLE IF NOT EXISTS dim_registration_hist
(
    registration_id  INTEGER NOT NULL
        CONSTRAINT pk_dim_registration_hist
            PRIMARY KEY,
    user_id          INTEGER
        CONSTRAINT unq_dim_registration_hist_user_id
            UNIQUE
        CONSTRAINT fk_dim_registration_hist_user_profile
            REFERENCES user_profile,
    utc_created_dttm VARCHAR,
    authorized_flg   BOOLEAN,
    utc_updated_dttm VARCHAR
);

COMMENT ON TABLE dim_registration_hist IS '- Таблица с историей регистрации пользователей';

COMMENT ON COLUMN dim_registration_hist.registration_id IS '- Идентификатор регистрации';

COMMENT ON COLUMN dim_registration_hist.user_id IS '- Идентификатор пользователя';

COMMENT ON COLUMN dim_registration_hist.utc_created_dttm IS '- Дата регистрации';

COMMENT ON COLUMN dim_registration_hist.authorized_flg IS '- Флаг авторизации';

COMMENT ON COLUMN dim_registration_hist.utc_updated_dttm IS '- Время изменения записи';

CREATE TABLE IF NOT EXISTS dim_user_session_hist
(
    user_session_id             INTEGER NOT NULL
        CONSTRAINT pk_dim_user_session_hist
            PRIMARY KEY,
    utc_session_start_dttm      VARCHAR,
    user_id                     INTEGER
        CONSTRAINT unq_dim_user_session_hist_user_id
            UNIQUE
        CONSTRAINT fk_dim_user_session_hist
            REFERENCES user_profile,
    utc_end_session_dttm        INTEGER,
    subscription_transaction_id INTEGER,
    aplication_version          INTEGER,
    device_id                   INTEGER
        CONSTRAINT user_session_hist_device_disct
            REFERENCES device_dict
);

COMMENT ON TABLE dim_user_session_hist IS '- Таблица с сессией пользователей\n\nСессия заначивается по следующим причинам:\n- Пользователь купил подписку;\n- Сессия длится > 2 часов;\n- Прошло > 30 минут с момента последнего события;';

COMMENT ON COLUMN dim_user_session_hist.user_session_id IS '- Идентификатор пользовательской сессии';

COMMENT ON COLUMN dim_user_session_hist.utc_session_start_dttm IS '- Время начала пользовательской сессии;';

COMMENT ON COLUMN dim_user_session_hist.user_id IS '- Идентификатор пользователя';

COMMENT ON COLUMN dim_user_session_hist.utc_end_session_dttm IS '- Время окончания сессии';

COMMENT ON COLUMN dim_user_session_hist.subscription_transaction_id IS '- Идентификатор транзакции, с помощью которой приобрели подписку, если она была';

COMMENT ON COLUMN dim_user_session_hist.aplication_version IS '- Версия приложения';

COMMENT ON COLUMN dim_user_session_hist.device_id IS '- Идентификатор устройства';

CREATE TABLE IF NOT EXISTS dim_game_session_hist
(
    game_session_id        INTEGER NOT NULL
        CONSTRAINT pk_dim_game_session_id
            PRIMARY KEY,
    utc_session_start_dttm VARCHAR,
    utc_session_end_dttm   VARCHAR,
    user_id                INTEGER
        CONSTRAINT game_session_id_user_profile
            REFERENCES user_profile,
    game_id                INTEGER
        CONSTRAINT fk_dim_game_session_id
            REFERENCES game_dict (game_id),
    final_points           INTEGER,
    user_session_id        INTEGER
        CONSTRAINT game_session_id_user_session_id
            REFERENCES dim_user_session_hist,
    burned_calories_num    INTEGER,
    application_version    INTEGER,
    device_id              INTEGER
);

COMMENT ON TABLE dim_game_session_hist IS '- Таблица с описанием игровых сессий';

COMMENT ON COLUMN dim_game_session_hist.game_session_id IS '- Индентификатор игровой сессии';

COMMENT ON COLUMN dim_game_session_hist.utc_session_start_dttm IS '- Время начала игровой сессии';

COMMENT ON COLUMN dim_game_session_hist.utc_session_end_dttm IS '- Время окончания игровой сессии';

COMMENT ON COLUMN dim_game_session_hist.user_id IS '- Идентификатор пользователя';

COMMENT ON COLUMN dim_game_session_hist.game_id IS '- Идентификатор игры';

COMMENT ON COLUMN dim_game_session_hist.final_points IS '- Финальное количество набранных очков в конце игры';

COMMENT ON COLUMN dim_game_session_hist.user_session_id IS '- Идентификатор сессии пользователя';

COMMENT ON COLUMN dim_game_session_hist.burned_calories_num IS '- Количество сожженных калорий во время игры';

COMMENT ON COLUMN dim_game_session_hist.application_version IS '- Версия приложения';

COMMENT ON COLUMN dim_game_session_hist.device_id IS '- Идентификатор устройства';

CREATE TABLE IF NOT EXISTS user_achieves_hist
(
    achive_transaction_id        INTEGER NOT NULL
        CONSTRAINT pk_user_achieves_hist
            PRIMARY KEY,
    user_id                      INTEGER
        CONSTRAINT fk_user_achieves_hist_user_profile
            REFERENCES user_profile,
    utc_achieve_transaction_dttm VARCHAR,
    user_session_id              INTEGER,
    item_id                      INTEGER,
    game_session_id              INTEGER,
    achieve_reason_type          VARCHAR
);

COMMENT ON TABLE user_achieves_hist IS '- Таблица с историей получения ачивок пользователем';

COMMENT ON COLUMN user_achieves_hist.achive_transaction_id IS '- id транзакции, в которой получена';

COMMENT ON COLUMN user_achieves_hist.user_id IS '- Идентификатор пользователя';

COMMENT ON COLUMN user_achieves_hist.utc_achieve_transaction_dttm IS '- Время получения ачивки пользователем (UTC)';

COMMENT ON COLUMN user_achieves_hist.user_session_id IS '- Идентификатор пользовательской сессии';

COMMENT ON COLUMN user_achieves_hist.item_id IS '- Идентификатор ачивки';

COMMENT ON COLUMN user_achieves_hist.game_session_id IS '- Индентификатор игровой сессии, если ачивка была получена после игры';

COMMENT ON COLUMN user_achieves_hist.achieve_reason_type IS '- Причина получения ачивка';

CREATE TABLE IF NOT EXISTS user_purchase_hist
(
    transaction_id            INTEGER NOT NULL
        CONSTRAINT pk_user_transactions
            PRIMARY KEY,
    user_id                   INTEGER
        CONSTRAINT user_transactions_user_profile
            REFERENCES user_profile,
    currency                  VARCHAR,
    item_cost                 INTEGER,
    utc_transaction_dttm      VARCHAR,
    user_item_cost            INTEGER,
    item_id                   INTEGER
        CONSTRAINT user_transactions_purchase
            REFERENCES purchase_dict (purchase_id)
        CONSTRAINT user_transactions_subscription
            REFERENCES subscription_dict (subscription_id),
    user_session_id           INTEGER
        CONSTRAINT user_transactions_user_session
            REFERENCES dim_user_session_hist,
    "is_monetary transaction" BOOLEAN,
    сurrency_rate             BOOLEAN,
    success_transaction_flg   BOOLEAN
);

COMMENT ON TABLE user_purchase_hist IS '- Таблица со всеми покупками  (товары/баллы/подписки) (на деньги или баллы пользователя)';

COMMENT ON COLUMN user_purchase_hist.transaction_id IS '- Идентификатор транзакции';

COMMENT ON COLUMN user_purchase_hist.user_id IS '- Идентификатор пользователя';

COMMENT ON COLUMN user_purchase_hist.currency IS '- Валюта транзакции (баллы/ рубли/ доллары)';

COMMENT ON COLUMN user_purchase_hist.item_cost IS '- Стоимость товара до скидки';

COMMENT ON COLUMN user_purchase_hist.utc_transaction_dttm IS '- Время транзакции (UTC)';

COMMENT ON COLUMN user_purchase_hist.user_item_cost IS '- Стоимость товара для пользователя';

COMMENT ON COLUMN user_purchase_hist.item_id IS '- Индетификатор товара';

COMMENT ON COLUMN user_purchase_hist.user_session_id IS '- Идентификатор сессии пользователя';

COMMENT ON COLUMN user_purchase_hist."is_monetary transaction" IS '- Флаг операции за реальные деньги';

COMMENT ON COLUMN user_purchase_hist.сurrency_rate IS '- Курс валюты (если операция денежная)';

COMMENT ON COLUMN user_purchase_hist.success_transaction_flg IS '- Флаг удачной транзакции';

ALTER TABLE user_profile
    ADD CONSTRAINT fk_user_profile
        FOREIGN KEY (subsription_transaction_id) REFERENCES user_purchase_hist;

ALTER TABLE dim_user_session_hist
    ADD CONSTRAINT dim_user_session_hist_transaction_id
        FOREIGN KEY (subscription_transaction_id) REFERENCES user_purchase_hist;

CREATE TABLE IF NOT EXISTS dim_user_balance_hist
(
    balance_transaction_id INTEGER NOT NULL
        CONSTRAINT pk_dim_points_balance_hist
            PRIMARY KEY,
    user_id                INTEGER
        CONSTRAINT fk_dim_points_balance_hist
            REFERENCES user_profile,
    utc_valid_from_dttm    VARCHAR,
    wallet_id              INTEGER,
    utc_valid_to_dttm      VARCHAR,
    balance_points_amt     VARCHAR,
    user_session_id        INTEGER
        CONSTRAINT dim_user_balance_hist_user_session
            REFERENCES dim_user_session_hist,
    change_balance_reason  VARCHAR,
    num_points             INTEGER,
    game_session_id        INTEGER
        CONSTRAINT fk_dim_user_balance_hist
            REFERENCES dim_game_session_hist,
    transaction_id         INTEGER
        CONSTRAINT dim_user_balance_hist_user_transaction
            REFERENCES user_purchase_hist
);

COMMENT ON TABLE dim_user_balance_hist IS '- Таблица с балансом счета пользователей';

COMMENT ON COLUMN dim_user_balance_hist.balance_transaction_id IS '- Идентификатор транзакции, которая меняет баланс пользователя';

COMMENT ON COLUMN dim_user_balance_hist.user_id IS '- Идентификатор пользователя';

COMMENT ON COLUMN dim_user_balance_hist.utc_valid_from_dttm IS '- Время начала валидности баланса';

COMMENT ON COLUMN dim_user_balance_hist.wallet_id IS '- Идентификатор счета пользователя';

COMMENT ON COLUMN dim_user_balance_hist.utc_valid_to_dttm IS '- Время окончания валидности баланса пользователя';

COMMENT ON COLUMN dim_user_balance_hist.balance_points_amt IS '- Суммарное кол-во баллов на счету пользователя';

COMMENT ON COLUMN dim_user_balance_hist.user_session_id IS '- Идентификатор сессии пользователя';

COMMENT ON COLUMN dim_user_balance_hist.change_balance_reason IS '- Причина изменения баланса пользователя (игра, покупка баллов за реальные деньги, трата баллов  на покупки и тд)';

COMMENT ON COLUMN dim_user_balance_hist.num_points IS '- Количество баллов , которое  получил/потратил пользователь в транзакции';

COMMENT ON COLUMN dim_user_balance_hist.game_session_id IS '- Идентификатор игры, благодаря которой изменился баланс баллов пользователя\n- Если баллы купили, то Null';

COMMENT ON COLUMN dim_user_balance_hist.transaction_id IS '- Идентификатор транзакции, если баллы купили/потратили';
