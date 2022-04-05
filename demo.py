from flask import (
    Blueprint, render_template
)

bp = Blueprint('demo', __name__)


@bp.route('/')
def index():
    return render_template('demo/index.html')

@bp.route('/user')
def user_page():
    return render_template('auth/user.html')
