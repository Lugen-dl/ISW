FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .

RUN npm run build

RUN chmod +x scripts/dev.sh scripts/prod.sh

FROM node:22-alpine AS production

RUN apk add --no-cache git tini

WORKDIR /app

RUN adduser -S appuser 
    
COPY --from=builder /app/ /app

RUN chown -R appuser:nobody /app && \
    chmod -R 755 /app

USER appuser

EXPOSE 5480
EXPOSE 5481

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["sh", "/app/scripts/prod.sh"]
