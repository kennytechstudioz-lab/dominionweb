#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Deploying Dominion Web..."
npm install
npm run build

# Copy static assets to the standalone directory
cp -r public .next/standalone/
cp -r .next/static .next/standalone/.next/

# Restart/Start standalone server using PM2
pm2 restart .next/standalone/server.js --name "dominion-web" || pm2 start .next/standalone/server.js --name "dominion-web"

echo "Dominion Web deployed successfully!"
