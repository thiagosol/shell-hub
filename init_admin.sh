#!/bin/sh

echo "📢 Verificando se o usuário admin já existe..."

until mongosh --quiet --eval "db.runCommand({ ping: 1 })" "${SHELLHUB_MONGO_URI}"; do
    echo "⏳ Aguardando MongoDB..."
    sleep 2
done

echo "✅ MongoDB conectado!"

EXISTING_USER=$(mongosh --quiet --eval "
db = db.getSiblingDB('shellhub');
db.users.findOne({ email: '${ADMIN_USER}' });
" "${SHELLHUB_MONGO_URI}")

if [ "$EXISTING_USER" != "null" ]; then
    echo "✅ Usuário '${ADMIN_USER}' já existe. Nada será feito."
else
    echo "🔑 Criando usuário admin..."
    
    HASHED_PASS=$(python3 -c "
      import bcrypt;
      print(bcrypt.hashpw('${ADMIN_PASS}'.encode(), bcrypt.gensalt()).decode())
    ")

    mongosh --quiet --eval "
    db = db.getSiblingDB('shellhub');
    db.users.insertOne({
        username: '${ADMIN_USER}',
        email: '${ADMIN_EMAIL}',
        password: '${HASHED_PASS}',
        confirmed: true,
        created_at: new Date(),
        role: 'admin'
    });
    " "${SHELLHUB_MONGO_URI}"

    echo "✅ Usuário '${ADMIN_USER}' criado com sucesso!"
fi

exec "$@"
