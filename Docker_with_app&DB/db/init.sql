CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INT NOT NULL
);

INSERT INTO users (name, age) VALUES
('Aidana', 22),
('Aiperi_I', 21);