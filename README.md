# Laravel API + MySQL (Kubernetes, k3d)

## Requirements

* Docker
* k3d
* kubectl
* make

---

## Run

```bash
make up
```

---

## API

```bash
# health
curl http://localhost:30007/api/health

# get items
curl http://localhost:30007/api/items

# create item
curl -X POST http://localhost:30007/api/items \
  -H "Content-Type: application/json" \
  -d '{"name":"Milk"}'
```

---

## Stop

```bash
make down
```

---

## Components

* Laravel API (GET / POST endpoints)
* MySQL (StatefulSet)
* PersistentVolumeClaim (data storage)
* ConfigMap + Secret (configuration)
* Deployment (application)
* Service (internal communication)

---

## Tradeoffs

* Using `php artisan serve` instead of nginx/php-fpm (simplification)
* Minimal setup to keep the solution straightforward

---

## Health checks

* Liveness and readiness probes are configured using the /api/health endpoint.
