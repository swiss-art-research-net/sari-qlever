#!/bin/sh
CHECKFILE=/status/.qlever-ui-initialized

if [ ! -f "$CHECKFILE" ]; then
    echo "First time database initialization"
    python manage.py migrate

    echo "Removing demo user if it exists..."
    python manage.py shell -c "
from django.contrib.auth import get_user_model
User = get_user_model()
User.objects.filter(username='demo').delete()
"

    touch "$CHECKFILE"
    echo "Database initialization completed"
fi

# Start the QLever UI service
exec gunicorn --bind :7000 --workers 3 --limit-request-line 10000 qlever.wsgi:application