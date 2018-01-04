// We're going to build a new subnav
subNav = document.createElement('ul');
subNav.classList.add('sub-nav');

// Add nav items for each heading
headings = Array.prototype.slice.call(document.querySelectorAll('h1, h2'), 0)
headings.forEach(
    function(heading) {
        if (heading.id) {
            item = document.createElement('li')

            anchor = document.createElement('a');
            anchor.href = '#' + heading.id;
            anchor.innerText = '# ' + heading.innerText;

            item.appendChild(anchor)

            subNav.appendChild(item)
        }
    }
)

// Add the subnav to the end of the header
header = document.querySelector('.page-header');
header.appendChild(subNav)
