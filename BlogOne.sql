-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 07, 2021 at 11:36 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `BlogOne`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `p_no` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`sno`, `name`, `email`, `p_no`, `msg`, `date`) VALUES
(1, 'first', 'test@gmail.com', '12345678890', 'test', '2021-10-23 10:09:50'),
(13, 'gsr ', 'srg@sve.com', 'sg d', 'sgr dwv', '2021-11-05 10:35:52'),
(14, 'gsr ', 'srg@sve.com', 'sg d', 'sgr dwv', '2021-11-05 10:36:33');

-- --------------------------------------------------------

--
-- Table structure for table `contribute`
--

CREATE TABLE `contribute` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `p_no` varchar(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contribute`
--

INSERT INTO `contribute` (`sno`, `name`, `email`, `p_no`, `title`, `tagline`, `content`, `date`) VALUES
(1, 'demo', 'test@gmail.com', '12345678890', 'demo', 'demo', 'demo', '2021-11-06 17:33:23');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(50) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `author` text DEFAULT '\'\\\'Admin\\\'\'',
  `img_file` varchar(200) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `author`, `img_file`, `date`) VALUES
(1, 'Stock market', 'Let\'s learn about Stock market', 'stock-market', 'A Stock market, Equity market, or share market is the aggregation of buyers and sellers of stocks (also called shares), which represent ownership claims on businesses; these may include securities listed on a public stock exchange, as well as stock that is only traded privately, such as shares of private companies which are sold to investors through equity crowdfunding platforms. Investment in the stock market is most often done via stockbrokerages and electronic trading platforms. Investment is usually made with an investment strategy in mind. \r\n\r\nThe total market capitalisation of equity backed securities worldwide rose from US$ 2.5 trillion in 1980 to US$ 83.53 trillion at the end of 2019. As of December 31, 2019, the total market capitalisation of all stocks worldwide was approximately US$70.75 trillion.\r\n\r\nAs of 2016, there are 60 stock exchanges in the world. Of these, there are 16 exchanges with a market capitalisation of $1 trillion or more, and they account for 87% of global market capitalisation. Apart from the Australian Securities Exchange, these 16 exchanges are all in either North America, Europe, or Asia.\r\n\r\nBy country, the largest stock markets as of January 2021 are in the United States of America (about 55.9%), followed by Japan (about 7.4%) and China (about 5.4%).\r\n\r\nStocks can be categorised by the country where the company is domiciled. For example, Nestlé and Novartis are domiciled in Switzerland and traded on the SIX Swiss Exchange, so they may be considered as part of the Swiss stock market, although the stocks may also be traded on exchanges in other countries, for example, as American depositary receipts (ADRs) on U.S. stock markets.', 'Admin ', 'Stock market.jpeg', '2021-09-16 00:00:00'),
(2, 'Stereoscopy', 'Let\'s learn about Stereoscopy', 'Stereoscopy', 'Spectroscopy is the study of the interaction between matter and electromagnetic radiation as a function of the wavelength or frequency of the radiation. In simpler terms, spectroscopy is the precise study of color as generalized from visible light to all bands of the electromagnetic spectrum; indeed, historically, spectroscopy originated as the study of the wavelength dependence of the absorption by gas phase matter of visible light dispersed by a prism. Matter waves and acoustic waves can also be considered forms of radiative energy, and recently gravitational waves have been associated with a spectral signature in the context of the Laser Interferometer Gravitational-Wave Observatory (LIGO).\r\n\r\nSpectroscopy, primarily in the electromagnetic spectrum, is a fundamental exploratory tool in the fields of physics, chemistry, and astronomy, allowing the composition, physical structure and electronic structure of matter to be investigated at the atomic, molecular and macro scale, and over astronomical distances. Important applications arise from biomedical spectroscopy in the areas of tissue analysis and medical imaging.', 'Admin', 'Stereoscopy.png', '2021-11-06 17:32:46'),
(42, 'Artificial intelligence', 'The Future of Computing', 'AI', 'Artificial intelligence (AI) is intelligence demonstrated by machines, as opposed to natural intelligence displayed by animals including humans. Leading AI textbooks define the field as the study of \"intelligent agents\": any system that perceives its environment and takes actions that maximise its chance of achieving its goals.Some popular accounts use the term \"artificial intelligence\" to describe machines that mimic \"cognitive\" functions that humans associate with the human mind, such as \"learning\" and \"problem solving\", however, this definition is rejected by major AI researchers.\r\n\r\nAI applications include advanced web search engines (i.e. Google), recommendation systems (used by YouTube, Amazon and Netflix), understanding human speech (such as Siri and Alexa), self-driving cars (e.g. Tesla), automated decision-making and competing at the highest level in strategic game systems (such as chess and Go).As machines become increasingly capable, tasks considered to require \"intelligence\" are often removed from the definition of AI, a phenomenon known as the AI effect. For instance, optical character recognition is frequently excluded from things considered to be AI, having become a routine technology.\r\n\r\nArtificial intelligence was founded as an academic discipline in 1956, and in the years since has experienced several waves of optimism, followed by disappointment and the loss of funding (known as an \"AI winter\"), followed by new approaches, success and renewed funding. AI research has tried and discarded many different approaches since its founding, including simulating the brain, modelling human problem solving, formal logic, large databases of knowledge and imitating animal behavior. In the first decades of the 21st century, highly mathematical statistical machine learning has dominated the field, and this technique has proved highly successful, helping to solve many challenging problems throughout industry and academia.\r\n\r\nThe various sub-fields of AI research are centred around particular goals and the use of particular tools. The traditional goals of AI research include reasoning, knowledge representation, planning, learning, natural language processing, perception, and the ability to move and manipulate objects.General intelligence (the ability to solve an arbitrary problem) is among the field\'s long-term goals. To solve these problems, AI researchers have adapted and integrated a wide range of problem-solving techniques -- including search and mathematical optimisation, formal logic, artificial neural networks, and methods based on statistics, probability and economics. AI also draws upon computer science, psychology, linguistics, philosophy, and many other fields.\r\n\r\nThe field was founded on the assumption that human intelligence \"can be so precisely described that a machine can be made to simulate it\".This raises philosophical arguments about the mind and the ethics of creating artificial beings endowed with human-like intelligence. These issues have been explored by myth, fiction, and philosophy since antiquity. Science fiction and futurology have also suggested that, with its enormous potential and power, AI may become an existential risk to humanity.', 'Admin', 'AI.jpeg', '2021-11-07 15:41:31'),
(43, 'Civil Services Examination', 'One of the toughest examination in the world', 'Civil-Services-Examination', 'The Civil Services Examination (CSE) is a nationwide competitive examination in India conducted by the Union Public Service Commission for recruitment to higher Civil Services of the Government of India, including the Indian Administrative Service, Indian Foreign Service, and Indian Police Service. Also simply referred to as the UPSC examination, it is conducted in three phases - a preliminary examination consisting of two objective-type papers (General Studies Paper I and General Studies Paper II also popularly known as Civil Service Aptitude Test or CSAT), and a main examination consisting of nine papers of conventional (essay) type, in which two papers are qualifying and only marks of seven are counted followed by a personality test (interview). A successful candidate sits for 32 hours of examination during the complete process.', 'Admin', 'upsc-cse.jpeg', '2021-11-07 15:58:12'),
(44, 'Programming language', 'Converse with your Computer', 'programming-language', 'A programming language is a formal language comprising a set of strings that produce various kinds of machine code output. Programming languages are one kind of computer language, and are used in computer programming to implement algorithms.\r\n\r\nMost programming languages consist of instructions for computers. There are programmable machines that use a set of specific instructions, rather than general programming languages. Since the early 1800s, programs have been used to direct the behavior of machines such as Jacquard looms, music boxes and player pianos. The programs for these machines (such as a player piano\'s scrolls) did not produce different behavior in response to different inputs or conditions.\r\n\r\nThousands of different programming languages have been created, and more are being created every year. Many programming languages are written in an imperative form (i.e., as a sequence of operations to perform) while other languages use the declarative form (i.e. the desired result is specified, not how to achieve it).\r\n\r\nThe description of a programming language is usually split into the two components of syntax (form) and semantics (meaning). Some languages are defined by a specification document (for example, the C programming language is specified by an ISO Standard) while other languages (such as Perl) have a dominant implementation that is treated as a reference. Some languages have both, with the basic language defined by a standard and extensions taken from the dominant implementation being common.\r\n\r\nProgramming language theory is a subfield of computer science that deals with the design, implementation, analysis, characterisation, and classification of programming languages.', 'Admin', 'Programming language.png', '2021-11-07 16:02:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `contribute`
--
ALTER TABLE `contribute`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contribute`
--
ALTER TABLE `contribute`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
