document.addEventListener('DOMContentLoaded', () => {

  /* ==========================================================================
     1. Scroll-Triggered Top-Left Navbar Logo Fade-In & Mobile Menu Toggle
     ========================================================================== */
  const navbar = document.querySelector('.navbar');
  const heroLogo = document.querySelector('.hero-logo-box');
  const mobileToggle = document.getElementById('mobileMenuBtn') || document.querySelector('.mobile-toggle');
  const navMenu = document.querySelector('.nav-menu');
  const navLinks = document.querySelectorAll('.nav-link, .btn-contact');

  function handleScrollLogo() {
    if (!heroLogo) return;
    const heroLogoRect = heroLogo.getBoundingClientRect();
    
    // When the main Hero logo scrolls above 80px from top, fade in navbar top-left logo
    if (heroLogoRect.bottom < 80) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }
  }

  window.addEventListener('scroll', handleScrollLogo);
  handleScrollLogo(); // Initial check

  // Mobile Hamburger Menu Click & Touch Event Handler
  if (mobileToggle && navMenu) {
    function toggleMobileMenu(e) {
      if (e) e.preventDefault();
      mobileToggle.classList.toggle('active');
      navMenu.classList.toggle('active');
      
      if (navMenu.classList.contains('active')) {
        document.body.style.overflow = 'hidden';
      } else {
        document.body.style.overflow = 'auto';
      }
    }

    mobileToggle.addEventListener('click', toggleMobileMenu);

    // Close menu when a link inside mobile menu is clicked
    navLinks.forEach(link => {
      link.addEventListener('click', () => {
        mobileToggle.classList.remove('active');
        navMenu.classList.remove('active');
        document.body.style.overflow = 'auto';
      });
    });
  }


  /* ==========================================================================
     2. Portfolio Grid Filter & Peeking Gradient Mask Handler
     ========================================================================== */
  const filterBtns = document.querySelectorAll('.filter-btn');
  const workCards = Array.from(document.querySelectorAll('.work-card'));
  const portfolioGrid = document.querySelector('.portfolio-grid');
  const portfolioWrapper = document.getElementById('portfolioWrapper');
  const loadMoreBtn = document.getElementById('loadMoreBtn');
  const loadMoreBox = document.getElementById('loadMoreBox');

  let activeFilter = 'all';
  let isExpanded = false;

  // Shuffle Helper function (Fisher-Yates Shuffle)
  function shuffleArray(array) {
    const shuffled = [...array];
    for (let i = shuffled.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    }
    return shuffled;
  }

  // Update Grid Display based on filter & expand state
  function updatePortfolioDisplay() {
    // Get matching cards based on active filter
    let matchingCards = workCards.filter(card => {
      const category = card.getAttribute('data-category');
      return activeFilter === 'all' || category === activeFilter;
    });

    // Hide all cards initially
    workCards.forEach(card => {
      card.style.display = 'none';
      card.classList.remove('card-featured', 'card-wide');
    });

    // Shuffle matching cards
    const shuffledCards = shuffleArray(matchingCards);

    // Append and display matching cards
    shuffledCards.forEach((card, idx) => {
      portfolioGrid.appendChild(card);
      card.style.display = 'block';

      // Apply featured layout variations for individual category views
      if (activeFilter !== 'all') {
        if (idx % 5 === 0) {
          card.classList.add('card-featured');
        } else if (idx % 7 === 0) {
          card.classList.add('card-wide');
        }
      }
    });

    // Determine whether to show the peeking mask & Load More button
    if (matchingCards.length > 8 && !isExpanded) {
      portfolioWrapper.style.maxHeight = '';
      portfolioWrapper.classList.add('collapsed');
      portfolioWrapper.classList.remove('expanded');
      loadMoreBox.style.display = 'flex';
      loadMoreBox.style.opacity = '1';
      loadMoreBtn.innerText = `MORE PROJECTS (${matchingCards.length - 8} MORE) +`;
    } else {
      portfolioWrapper.style.maxHeight = '';
      portfolioWrapper.classList.remove('collapsed');
      portfolioWrapper.classList.add('expanded');
      loadMoreBox.style.display = 'none';
    }
  }

  // Filter Button Click Handler (Smooth Apple-Style Grid Cross-Fade)
  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const newFilter = btn.getAttribute('data-filter');
      if (activeFilter === newFilter) return;

      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      activeFilter = newFilter;
      isExpanded = false;

      // Soft, subtle grid cross-fade (Zero blinking)
      portfolioGrid.style.transition = 'opacity 0.14s ease, transform 0.14s ease';
      portfolioGrid.style.opacity = '0.35';
      portfolioGrid.style.transform = 'translateY(6px)';

      setTimeout(() => {
        updatePortfolioDisplay();
        portfolioGrid.style.transition = 'opacity 0.28s ease, transform 0.28s ease';
        portfolioGrid.style.opacity = '1';
        portfolioGrid.style.transform = 'translateY(0)';
      }, 130);
    });
  });

  // Load More Button Click Handler (Expands container smoothly to exact scrollHeight)
  if (loadMoreBtn) {
    loadMoreBtn.addEventListener('click', () => {
      isExpanded = true;
      const targetHeight = portfolioWrapper.scrollHeight;
      portfolioWrapper.style.maxHeight = targetHeight + 'px';
      portfolioWrapper.classList.remove('collapsed');
      portfolioWrapper.classList.add('expanded');

      setTimeout(() => {
        if (isExpanded) {
          portfolioWrapper.style.maxHeight = 'none';
        }
      }, 850);

      loadMoreBox.style.transition = 'opacity 0.4s ease';
      loadMoreBox.style.opacity = '0';
      setTimeout(() => {
        loadMoreBox.style.display = 'none';
      }, 400);
    });
  }

  // Initial Render
  updatePortfolioDisplay();


  /* ==========================================================================
     3. Vimeo Video Modal Popup Handler
     ========================================================================== */
  const videoModal = document.getElementById('videoModal');
  const vimeoPlayer = document.getElementById('vimeoPlayer');
  const modalTitle = document.getElementById('modalTitle');
  const modalVimeoDirect = document.getElementById('modalVimeoDirect');
  const modalCloseBtn = document.getElementById('modalCloseBtn');
  const modalOverlay = document.getElementById('modalOverlay');

  // Open Video Modal on Card Click
  workCards.forEach(card => {
    card.addEventListener('click', (e) => {
      // Ignore click if clicking direct Vimeo link button
      if (e.target.closest('.vimeo-direct-btn') || e.target.closest('.vimeo-link')) {
        return;
      }

      const vimeoLinkElem = card.querySelector('.vimeo-link');
      if (!vimeoLinkElem) return;

      const fullUrl = vimeoLinkElem.getAttribute('href');
      const cardTitleText = card.querySelector('.card-title')?.innerText || 'KEEKANZ Video';

      // Extract Vimeo Video ID
      const match = fullUrl.match(/vimeo\.com\/(\d+)/);
      if (match && match[1]) {
        const videoId = match[1];
        vimeoPlayer.src = `https://player.vimeo.com/video/${videoId}?autoplay=1&title=0&byline=0&portrait=0`;
        modalTitle.innerText = cardTitleText;
        modalVimeoDirect.innerHTML = `<a href="${fullUrl}" target="_blank" rel="noopener">🔗 View original video on Vimeo (${fullUrl})</a>`;
        
        videoModal.classList.add('active');
        document.body.style.overflow = 'hidden';
      }
    });
  });

  // Close Video Modal Handler
  function closeModal() {
    videoModal.classList.remove('active');
    vimeoPlayer.src = '';
    document.body.style.overflow = 'auto';
  }

  if (modalCloseBtn) modalCloseBtn.addEventListener('click', closeModal);
  if (modalOverlay) modalOverlay.addEventListener('click', closeModal);

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && videoModal.classList.contains('active')) {
      closeModal();
    }
  });


  /* ==========================================================================
     4. Direct Instant Email Inquiry Form Submission (FormSubmit.co)
     ========================================================================== */
  const contactForm = document.getElementById('contactForm');
  if (contactForm) {
    contactForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const submitBtn = contactForm.querySelector('button[type="submit"]');
      const originalText = submitBtn ? submitBtn.innerText : 'Send Project Inquiry';
      
      if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.innerText = 'SENDING INQUIRY...';
      }

      try {
        const formData = new FormData(contactForm);
        const response = await fetch('https://formsubmit.co/ajax/kkhtpm06@naver.com', {
          method: 'POST',
          headers: { 
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(Object.fromEntries(formData))
        });

        const data = await response.json();
        if (response.ok || data.success === "true") {
          alert('감사합니다! 프로젝트 문의 메시지가 감독님 메일함(kkhtpm06@naver.com)으로 성공적으로 전달되었습니다.');
          contactForm.reset();
        } else {
          // Fallback to native form submission
          contactForm.submit();
        }
      } catch (err) {
        // Fallback to native form submission
        contactForm.submit();
      } finally {
        if (submitBtn) {
          submitBtn.disabled = false;
          submitBtn.innerText = originalText;
        }
      }
    });
  }

});
