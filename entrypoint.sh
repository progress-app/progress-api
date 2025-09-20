#!/bin/sh

echo "Waiting for database to be ready..."
until pg_isready -h postgres -p 5432 -U nestuser; do
  echo "Database is unavailable - sleeping"
  sleep 1
done

echo "Database is ready!"

echo "Generating Prisma client..."
npx prisma generate

echo "Running database migrations..."
npx prisma migrate deploy

echo "Starting application..."
npm run start:dev
