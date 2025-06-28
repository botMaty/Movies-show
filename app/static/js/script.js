// -----------------------------
// 🔧 تنظیم تم تاریک/روشن
// -----------------------------
function setupThemeToggle() {
  const modeToggle = document.getElementById("modeToggle");

  function setMode(mode) {
    if (mode === "dark") {
      document.body.classList.add("dark");
      modeToggle.textContent = "🌙";
    } else {
      document.body.classList.remove("dark");
      modeToggle.textContent = "☀️";
    }
    localStorage.setItem("theme", mode);
  }

  function disableTransitionOnce() {
    document.body.classList.add("no-transition");
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        document.body.classList.remove("no-transition");
      });
    });
  }

  // بارگذاری اولیه تم
  disableTransitionOnce();
  const savedTheme = localStorage.getItem("theme") || "light";
  setMode(savedTheme);

  modeToggle.addEventListener("click", () => {
    const isDark = document.body.classList.contains("dark");
    setMode(isDark ? "light" : "dark");
  });
}

// -----------------------------
// 📷 نمایش مودال عکس
// -----------------------------
function setupImageModal() {
    const modal = document.getElementById("imageModal");
    const modalImage = document.getElementById("modalImage");

    function closeImageModal() {
        modal.classList.remove("active");
        modalImage.src = "";
    }

    document.body.addEventListener("click", (e) => {
        if (e.target.classList.contains("poster-image")) {
            modalImage.src = e.target.src;
            modal.classList.add("active");
        } else if (e.target === modal || e.target === modalImage) {
            closeImageModal();
        }
    });

    if (modal !== null){
        modal.addEventListener("click", closeImageModal);
    }
    
}

// -----------------------------
// 🧾 سوئیچ فرم لاگین / ثبت‌نام
// -----------------------------
function setupAuthSwitch() {
    const container = document.getElementById('login-container');
    const registerBtn = document.getElementById('register');
    const loginBtn = document.getElementById('login');

    if (registerBtn && loginBtn && container) {
        registerBtn.addEventListener('click', () => {
            container.classList.add("active");
        });

        loginBtn.addEventListener('click', () => {
            container.classList.remove("active");
        });
    }
}

// -----------------------------
// ⭐ مودال نظر و امتیازدهی
// -----------------------------
function setupReviewModal() {
    const openModalBtn = document.getElementById('openModal');
    const modal = document.getElementById('modal');
    const closeModalBtn = document.getElementById('closeModal');
    const stars = document.querySelectorAll('.star');
    const reviewInput = document.getElementById('review');
    const submitBtn = document.getElementById('submitReview');

    if (openModalBtn === null)
        return;

    let selectedRating = 0;

    openModalBtn.addEventListener('click', () => {
        modal.style.display = 'flex';
        // reviewInput.value = '';
        selectedRating = 0;
        stars.forEach(star => star.classList.remove('selected'));
    });

    closeModalBtn.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.style.display = 'none';
        }
    });

    stars.forEach(star => {
        star.addEventListener('click', () => {
            selectedRating = parseInt(star.getAttribute('data-value'));
            stars.forEach(s => s.classList.remove('selected'));
            stars.forEach(s => {
                if (parseInt(s.getAttribute('data-value')) <= selectedRating) {
                    s.classList.add('selected');
                }
            });
        });

        star.addEventListener('mouseover', () => {
            const hoverValue = parseInt(star.getAttribute('data-value'));
            stars.forEach(s => s.classList.remove('hovered'));
            stars.forEach(s => {
                if (parseInt(s.getAttribute('data-value')) <= hoverValue) {
                    s.classList.add('hovered');
                }
            });
        });

        star.addEventListener('mouseout', () => {
            stars.forEach(s => s.classList.remove('hovered'));
        });
    });

    submitBtn.addEventListener('click', () => {
        if (logged_in === "False") {
            alert('Please login first');
            return;
        }
        if (selectedRating === 0) {
            alert('Please select a star rating first.');
            return;
        }
        const reviewText = reviewInput.value.trim();
        if (!reviewText) {
            alert('Please write your review.');
            return;
        }

        fetch('/submit_comment', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                rate: selectedRating,
                comment_text: reviewText,
                mid: movieId  // این رو یا از تگ مخفی بگیر یا جاوااسکریپت
            })
        })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                modal.style.display = 'none';
            } else {
                alert('Failed to submit review: ' + data.message);
            }
        })
        .catch(err => {
            console.error('Error:', err);
            alert('An error occurred while submitting your review.');
        });
    });

}

// -----------------------------
// 🚀 اجرای همه بخش‌ها بعد از لود
// -----------------------------
document.addEventListener("DOMContentLoaded", () => {
    setupThemeToggle();
    setupImageModal();
    setupAuthSwitch();
    setupReviewModal();
});
